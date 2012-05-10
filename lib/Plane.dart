#library("Plane");
#import("dart:html");
#import("fxPresenti.dart");

class Plane extends fxPresenti {
  Element element;
  ElementList slides;
  int current;
  int nextStep;
  int margin;
  num ratio;
  int originalWidth;
  int originalHeight;
  int maxHeight;
  
  Plane( String sWrapSelector, String sSlideSelector, int iMargin, int iMaxHeight ){
    var elPresent = document.query(sWrapSelector);
    var elSlides = elPresent.queryAll(sSlideSelector);
    var iRatio = 0;
    
    element = elPresent;
    slides = elSlides;

    ratio = elSlides[0].$dom_clientWidth / elSlides[0].$dom_clientHeight;
    originalWidth = elSlides[0].$dom_clientWidth;
    originalHeight = elSlides[0].$dom_clientHeight;
    margin = iMargin;
    maxHeight = iMaxHeight;
    current = 0;
    nextStep = 0;
    
  }

  void setPosition(){
    var iMargin = window.innerHeight - element.$dom_clientHeight;
    var iTop = 0;
    if( iMargin < 0 ){
      iTop = 0;
    }else{
      iTop = (iMargin / 2).floor();
    }

    element.style.position = "absolute";
    element.style.top = "${iTop}px";
  }

  void resizeSlide(){
    var iLength = slides.length;
    var i = 1;
    var iWidth = 0;
    var iHeight = 0;

    slides.forEach(function(el){
      if( i == 1 ){
        iWidth = originalWidth + (window.innerWidth-( originalWidth + margin));
        iHeight = iWidth / ratio;
        if( maxHeight < iHeight ){
          iWidth = maxHeight * ratio;
          iHeight = maxHeight;
        }
      }
      el.style.width = "${iWidth}px";
      el.style.height = "${iHeight}px";
      if( iLength == i ){
        el.style.margin = "0px ${(window.innerWidth - iWidth)/2}px 0px 150px";
      }else{
        if( i == 1 ){
          el.style.margin = "0px 0px 0px ${(window.innerWidth - iWidth)/2}px";
        }else{
          el.style.margin = "0px 0px 0px 150px";
        }
      }
      i++;
    });
  }
  
  void slideAction(bool action){
    switch(action){
      case true:
        ElementList nextSlides = slides[current].queryAll(".next");
      print(nextSlides);
        if( nextSlides.length > 0 && nextStep <= (nextSlides.length-1) ){
          nextSlides[nextStep++].style.display = "block";
        }else{
          if( current < slides.length ) current++;
          window.scrollBy(( slides[0].$dom_clientWidth + 154 ), 0);
          nextStep = 0;
        }
        break;
      case false:
        if( current > 0 ) current--;
        window.scrollBy(((slides[0].$dom_clientWidth+154)*-1), 0);
        break;
    }
    print(current);
  }

  void fireEvent() {
    document.on.keyDown.add(function(event){
      switch(event.keyCode){
        case 32:
          slideAction(true);
          break;
        case 8:
          slideAction(false);
          event.preventDefault();
          break;
      }
    });
    window.on.resize.add(function(event){
      resizeSlide();
      setPosition();
    });
  }

}