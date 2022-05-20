class B12Float implements Number{
  // A displayable base 12 float. The display functionality is not currently used in the app
  private B12Digit[] digits;
  private float value;
  private PVector pos;
  private boolean arrayLoaded;
  private boolean inPosition;
  private int mode;// Can be RIGHT (39), CENTER (3), or LEFT (37)
  private int places;
  private int pointPlace;
  
  B12Float(float _value){
    value = _value;
    pos = new PVector(0,0);
    arrayLoaded = false;
    inPosition = false;
    mode = DECIMAL; // Not sure if this is still supported, but should def be discontinued
    places = 4;
  }
  
  // GETTERS //
  float getValue(){ return value; }
  PVector getPos(){ return pos; }
  int getPlaces(){ return places; }
  B12Int toInt(){return new B12Int(int(value));}
  B12Digit[] getDigits(){
    loadArray(); 
    B12Digit[] out = (B12Digit[])reverse(digits);
    for(int i = out.length-1; i > 0; i--){
      if(out[i].getValue() == '.'){
        out = (B12Digit[])shorten(out);
        break;
      }
      if(out[i].getValue() == 0){
        out = (B12Digit[])shorten(out);
      }
    }
    return out;
  }
  
  // SETTERS //
  B12Float setValue(float _value){ value = _value; arrayLoaded = false; return this;}
  B12Float setPos(PVector _pos){ pos = _pos.copy(); inPosition = false;return this; }
  B12Float setPos(float _x, float _y){ pos = new PVector(_x, _y); inPosition = false;return this; }
  B12Float setPlaces(int _places){ // Sets number of (dou)decimal places to display
    if(_places > 12 || _places < 0){ 
      throw new IllegalArgumentException("B12Float ncan only display to 12 duodecimal points");
    }else{
      places = _places;
    }
    return this;
  }
  B12Float setAlignMode(int _mode){
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
  
  private void positionDigits(){
    int curPos = 0;
    int count = 0;
    if(mode == LEFT){
      for(int i = 0; i < pointPlace; i++){
        curPos += -12;
        digits[i].setPos(curPos, 0);
        count++;
      }
      
      curPos += -8;
      digits[count].setPos(curPos, 0);
      count++;
      curPos += -6;
      digits[count].setPos(curPos, 0);
      count++;
      
      for(int i = count; i < digits.length; i++){
        curPos += -12;
        digits[i].setPos(curPos, 0);
      }
    }else if(mode == DECIMAL){
      curPos = -5;
      digits[pointPlace].setPos(curPos,0);
      curPos += -2;
      for(int i = pointPlace - 1; i >= 0; i--){
        curPos += 12;
        digits[i].setPos(curPos,0);
      }
      curPos = -2;
      
      for(int i = pointPlace + 1; i < digits.length; i++){
        curPos += -12;
        digits[i].setPos(curPos,0);
      }
    }else if(mode == RIGHT){
      for(int i = digits.length - 1; i >= 0; i--){
        digits[count].setPos((12 * i) + 3, 0);
        count++;
      }
    }
    inPosition = true;
  }
  
  private void loadArray(){
    //digits = new ArrayList<B12Digit>();
    digits = new B12Digit[0];
    B12Digit[] temp = new B12Digit[places];
    float mval = abs(value);
    int whole = int(mval);
    float deci = mval - float(whole);
    
    for(int i = 0; i < places; i++){
      deci *= 12;
      temp[i] = new B12Digit(int(deci));
      deci -= float(int(deci));
    }
    
    for(int i = places - 1; i >= 0; i--){
      digits = (B12Digit[])append(digits,temp[i]);
    }
    
    pointPlace = digits.length;
    digits = (B12Digit[])append(digits,new B12Digit('.'));
    
    while(whole > 0){
      if(whole < 12){
        digits = (B12Digit[])append(digits,new B12Digit(whole));
        whole = 0;
      }else{
        digits = (B12Digit[])append(digits,new B12Digit(whole % 12));
        whole /= 12;
      }
    }
    
    if(value < 0){
      digits = (B12Digit[])append(digits,new B12Digit('-'));
    }
    
    arrayLoaded = true;
    inPosition = false;
  }
}
