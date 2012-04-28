#library("Plane");
#import("dart:html");
#import("fxPresenti.dart");

class Plane extends fxPresenti {
  Element element;
  ElementList slides;
  int margin;
  num ratio;
  int originalWidth;
  int originalHeight;
  int maxHeight;

  void setOptions( Element el, ElementList a, int b, num c, int d, int e, int f ){
    element = el;
    slides = a;
    margin = b;
    ratio = c;
    originalWidth = d;
    originalHeight = e;
    maxHeight = f;
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

  Plane.fireEvent(ElementList slides) : super.fireEvent(slides){
    document.on.keyDown.add(function(event){
      switch(event.keyCode){
        case 32:
          window.scrollBy(( slides[0].$dom_clientWidth + 150 ), 0);
          break;
        case 8:
          window.scrollBy(((slides[0].$dom_clientWidth+150)*-1), 0);
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