class B12Digit implements Number{
  // A sngle displayable base 12 digit
  private byte value; // Using a byte allows storing characters natively in addition to numbers 0 through 11
  private PVector pos;
  private color col;
  
  B12Digit(int _value){
    if(_value >= 12 || _value < 0){ 
      throw new IllegalArgumentException("B12Digit only accepts decimal integers 0 through 11 -- " + _value); 
    }
    value = byte(_value);
    pos = new PVector(0,0);
    col = 0;
  }
  
  B12Digit(char _c){
    String valid = "+-*/.:()"; // Defines valid input characters. This can be added to in the future so long as the code to display the digit is added below
    if(!inStr(valid, _c)){ throw new IllegalArgumentException("B12Char only accepts \'+ - * / . :'"); }
    value = byte(_c);
    pos = new PVector(0,0);
    col = 0;
  }
  
  // SETTERS
  B12Digit setPos(PVector _pos){ pos = _pos; return this;}
  B12Digit setPos(float _x, float _y){ pos = new PVector(_x,_y); return this;}
  B12Digit setValue(int _value){ value = byte(_value); return this;}
  B12Digit setCol(color _col){col = _col; return this;}
  
  // GETTERS
  PVector getPos(){ return pos; }
  int getValue(){ return value; }
  boolean isNum(){return value >= 0 && value < 12; }
  color getCol(){return col;}
  
  // RENDER CHARACTERS
  void display(){
    pushMatrix();
    translate(pos.x,pos.y);
    strokeWeight(1);
    noFill();
    stroke(col);
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
      case '(':
        parenl(); break;
      case ')':
        parenr(); break;
    }
    popMatrix();
  }
  
  // Individual shape components to build any B12 number
  private void line0(){ quad(4,0,7,-6.5,4,-13,1,-6.5); }// ellipse(0,-13,8,0); }
  private void line1(){ line(6,0,9,-10); }
  private void line2(){ line(3,-10,6,0); }
  private void line3(){ line(0,0,3,-10); }
  private void line4(){ line(9,-10,2,-13); }
  private void line8(){ line(2,-13,9,-16); }
  
  // Individual shape components to build any B12 character
  private void lineTimes(){ line(4,-7,8,-3); line(4,-3,8,-7); } // multiplication symbol (x)
  private void dotsDiv(){ point(6,-8); point(6,-2); } // division symbol
  private void lineMinus(){ line(3,-5,9,-5); }
  private void linePlus(){ line(6,-8,6,-2); }
  private void period(){ point(5,0); }
  private void colon(){ point(5,-2); point(5,-8); }
  private void parenl(){ line(5,-13,3,-6.5); line(5,0,3,-6.5); }
  private void parenr(){ line(1,-13,3,-6.5); line(1,0,3,-6.5);}
  
  
  // HELPER FUNCTIONS //
  private boolean inStr(String st, char _c){ // Simply returns a boolean whether a character is present in a string
    try{
      int x = st.indexOf(_c);
      return true;
    }
    catch (Exception e){
      return false;
    }
  }
}
