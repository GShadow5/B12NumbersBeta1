class MathPad{
  B12Math math;
  
  MathPad(B12Math _math){
    math = _math;
  }
  
  // TODO draw a grid for buttons
  // TODO draw characters in grid
  // TODO detect mousepresses on the buttons (maybe a global mouse handler?)
  // TODO send characters to math
  
  void addchar(){
    math.expression.add(new B12Char('/'));
  }
}
