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
  
  B12Digit(char _c){
    String valid = "+-*/.:"; // Defines valid input characters
    if(inStr(valid, _c)){
      value = byte(_c);
    }else{ 
      throw new IllegalArgumentException("B12Char only accepts \'+ - * / . :'"); 
    }
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
      // NUMBERS //
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
        
      // CHARACTERS //
      case '+':
        lineMinus(); linePlus(); break;
      case '-':
        lineMinus(); break;
      case '*':
        lineTimes(); break;
      case '/':
        lineMinus(); dotsDiv(); break;
      case '.':
        strokeWeight(2); period(); break;
      case ':':
        strokeWeight(2); colon(); break;
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
  
  // Individual shape components to build any B12 character
  void lineTimes(){ line(4,-7,8,-3); line(4,-3,8,-7); }
  void dotsDiv(){ point(6,-8); point(6,-2); }
  void lineMinus(){ line(3,-5,9,-5); }
  void linePlus(){ line(6,-8,6,-2); }
  void period(){ point(5,0); }
  void colon(){ point(5,-2); point(5,-8); }
  
  
  // HELPER FUNCTIONS //
  boolean inStr(String st, char _c){
    try{
      int x = st.indexOf(_c);
      return true;
    }
    catch (Exception e){
      return false;
    }
  }
}
