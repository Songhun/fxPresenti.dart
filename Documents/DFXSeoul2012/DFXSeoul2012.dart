#import('dart:html');
#import('../../lib/Plane.dart');

void main() {

  final String sWrapSelector = "#presentation";
  final String sSlideSelector = ".slide";
  final int iMargin = 300;
  final int iMaxHeight = 600;

  var Slide = new Plane(sWrapSelector, sSlideSelector, iMargin, iMaxHeight);
  Slide.fireEvent();
  Slide.resizeSlide();
  Slide.setPosition();
}