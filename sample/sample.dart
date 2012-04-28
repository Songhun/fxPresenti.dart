#import('dart:html');
#import('../lib/Plane.dart');

main() {
  var sWrapSelector = "#presentation";
  var sSlideSelector = ".slide";
  var iMargin = 300;
  var iMaxHeight = 600;
  var elPresent = document.query(sWrapSelector);
  var elSlides = elPresent.queryAll(sSlideSelector);
  var iRatio = 0;

  iRatio = elSlides[0].$dom_clientWidth / elSlides[0].$dom_clientHeight;
  var iOriginWidth = elSlides[0].$dom_clientWidth;
  var iOriginHeight = elSlides[0].$dom_clientHeight;

  var Slide = new Plane.fireEvent(elSlides);
  Slide.setOptions(elPresent, elSlides, iMargin, iRatio, iOriginWidth, iOriginHeight, iMaxHeight);
  Slide.resizeSlide();
  Slide.setPosition();
}