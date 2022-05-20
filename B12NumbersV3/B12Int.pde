class B12Int implements Number {
  // A displayable base 12 integer. The display functionality is not currently used in the app
  private B12Digit[] digits;
  private int value;
  private PVector pos;
  private boolean arrayLoaded; // these bools store the state of the digit array. May no no longer be neccessary
  private boolean inPosition;
  private int mode;// Can be RIGHT (39), CENTER (3), or LEFT (37)
  private int minLen;
  
  B12Int(int _value){
    value = _value;
    pos = new PVector(0,0);
    arrayLoaded = false;
    inPosition = false;
    mode = LEFT;
    minLen = 0;
  }
  
  // GETTERS // 
  int getValue(){ return value; }
  PVector getPos(){ return pos; }
  B12Float toFloat(){return new B12Float(float(value)); }
  B12Digit[] getDigits(){ // Returns digits as an array. Used by calculator
    loadArray(); 
    B12Digit[] out = digits;
    return out;
  }
  
  // SETTERS //
  B12Int setValue(int _value){ value = _value; arrayLoaded = false; return this;}
  B12Int setPos(PVector _pos){ pos = _pos.copy(); inPosition = false; return this;}
  B12Int setPos(float _x, float _y){ pos = new PVector(_x, _y); inPosition = false;return this; }
  B12Int setMinLen(int i){ minLen = i; return this;}
  B12Int setAlignMode(int _mode){
    if(_mode == DECIMAL || _mode == LEFT || _mode == RIGHT){ mode = _mode; }
    else{ println("Alignment only accepts LEFT, RIGHT, and DECIMAL"); }
    return this;
  }
  
  void display(){
    if(!arrayLoaded){ loadArray(); }
    if(!inPosition){ positionDigits(); }
    pushMatrix();
    translate(pos.x,pos.y);
    for(int i = 0; i < digits.length; i++){
      digits[i].display();
    }
    popMatrix();
  }
  
  /*  Honestly, when it comes to the loading and positioning of digits in the number
      primitives, I don't remember the details, and since it needs to be rewritten 
      using a different structure anyway, I am not going to document it heavily. The
      only time it is used in this program is loadDigits being called before the 
      digits are output to the calculator which does its own positioning.
  */
  
  private void positionDigits(){ // Sets the position of each individual digit so the number renders properly in relation to its position
    if(mode == LEFT || mode == CENTER){
      for(int i = 0; i < digits.length; i++){
        digits[i].setPos((-12 * (i+1)), 0);
      }
    }else if(mode == RIGHT){
      int count = 0;
      for(int i = digits.length - 1; i >= 0; i--){
        digits[count].setPos((12 * i) + 3, 0);
        count++;
      }
    }
    inPosition = true;
  }
  
  private void loadArray(){ // Loads digits into the digit array converting value to base 12 in the process
    digits = new B12Digit[0];
    int mval = abs(value);
    if(mval == 0){ digits = (B12Digit[])append(digits, new B12Digit(0)); }
    while(mval != 0){
      if(mval < 12){
        digits = (B12Digit[])append(digits, new B12Digit(mval));
        mval = 0;
      }else{
        digits = (B12Digit[])append(digits, new B12Digit(mval % 12));
        mval /= 12;
      }
    }
    if(digits.length < minLen){
      digits = (B12Digit[])append(digits, new B12Digit(0));
    }
    if(value < 0){
      digits = (B12Digit[])append(digits, new B12Digit('-'));
    }
    
    arrayLoaded = true;
  }
}
