//package java.base.lang;
class B12Digit{
  byte value;
  PVector refPos;
  
  B12Digit(int _value){
    if(_value >= 12 || _value < 0){ 
      throw new IllegalArgumentException("B12Digit only accepts decimal integers 0 through 11"); 
    }
    value = byte(_value);
    refPos = new PVector(0,0);
  }
  
  // SETTERS
  void setRefPos(PVector _refPos){ refPos = _refPos; }
  void setRefPos(float _x, float _y){ refPos = new PVector(_x,_y); }
  void setValue(int _value){ value = byte(_value); }
  
  // GETTERS
  PVector getRefPos(){ return refPos; }
  int getValue(){ return value; }
  
  // RENDER CHARACTERS
  void display(){
    pushMatrix();
    translate(refPos.x,refPos.y);
    strokeWeight(1);
    noFill();
    ellipseMode(CORNERS);
    switch(value) {
      case 0:
        line0(); break;
      case 1:
        line1(); break;
      case 2:
        line1(); line2(); break;
      case 3:
        line1(); line2(); line3(); break;
      case 4:
        line4(); break;
      case 5:
        line4(); line1(); break;
      case 6:
        line4(); line1(); line2(); break;
      case 7:
        line4(); line1(); line2(); line3(); break;
      case 8:
        line8(); line4(); break;
      case 9:
        line8(); line4(); line1(); break;
      case 10:
        line8(); line4(); line1(); line2(); break;
      case 11:
        line8(); line4(); line1(); line2(); line3(); break;
    }
    popMatrix();
  }
  
  // Individual shape components to build any B12 number
  void line0(){ ellipse(0,-13,8,0); }
  void line1(){ line(6,0,9,-10); }
  void line2(){ line(3,-10,6,0); }
  void line3(){ line(0,0,3,-10); }
  void line4(){ line(9,-10,2,-13); }
  void line8(){ line(2,-13,9,-16); }
}
