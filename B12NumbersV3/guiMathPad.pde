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
    //math.expression.add(new B12Char('/'));
  }
}

// Deprecated since MethodRelay added
//class Button{
//  PVector pos; // Position to render from
//  PVector dim; // Second coordinate for CORNERS or len/wid for CORNER and CENTER
//  int radius; // Optional corner radius
//  color c;
//  Listener trigger;
//  BListener clickListener;
  
//  Button(PVector _pos, PVector _dim, Listener _trigger){
//    pos = _pos.copy();
//    dim = _dim.copy();
//    trigger = _trigger;
//  }
//  Button(PVector _pos, PVector _dim, int _radius, Listener _trigger){
//    pos = _pos.copy();
//    dim = _dim.copy();
//    trigger = _trigger;
//    radius = _radius;
//  }
  
//  class BListener extends Listener{
//    Button parent;
//    BListener(Handler mh, Button t){
//      super(mh);
//      parent = t;
//    }
    
//    void trigger(){
//      parent.trigger();
//    }
//  }
//}
