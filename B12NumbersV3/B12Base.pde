abstract interface Number{
  abstract PVector getPos();

  abstract void display();
}

class B12Digit implements Number{
  private byte value;
  private PVector refPos;
  
  B12Digit(int _value){
    if(_value >= 12 || _value < 0){ 
      throw new IllegalArgumentException("B12Digit only accepts decimal integers 0 through 11 -- " + _value); 
    }
    value = byte(_value);
    refPos = new PVector(0,0);
  }
  
  B12Digit(char _c){
    String valid = "+-*/.:()"; // Defines valid input characters
    if(!inStr(valid, _c)){ throw new IllegalArgumentException("B12Char only accepts \'+ - * / . :'"); }
    value = byte(_c);
    refPos = new PVector(0,0);
  }
  
  // SETTERS
  B12Digit setRefPos(PVector _refPos){ refPos = _refPos; return this;}
  B12Digit setRefPos(float _x, float _y){ refPos = new PVector(_x,_y); return this;}
  B12Digit setValue(int _value){ value = byte(_value); return this;}
  
  // GETTERS
  PVector getPos(){ return refPos; }
  int getValue(){ return value; }
  boolean isNum(){return value >= 0 && value < 12; }
  
  // RENDER CHARACTERS
  void display(){
    pushMatrix();
    translate(refPos.x,refPos.y);
    strokeWeight(1);
    noFill();
    stroke(1);
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
  private void lineTimes(){ line(4,-7,8,-3); line(4,-3,8,-7); }
  private void dotsDiv(){ point(6,-8); point(6,-2); }
  private void lineMinus(){ line(3,-5,9,-5); }
  private void linePlus(){ line(6,-8,6,-2); }
  private void period(){ point(5,0); }
  private void colon(){ point(5,-2); point(5,-8); }
  private void parenl(){ line(5,-13,3,-6.5); line(5,0,3,-6.5); }
  private void parenr(){ line(1,-13,3,-6.5); line(1,0,3,-6.5);}
  
  
  // HELPER FUNCTIONS //
  private boolean inStr(String st, char _c){
    try{
      int x = st.indexOf(_c);
      return true;
    }
    catch (Exception e){
      return false;
    }
  }
}



class B12Int implements Number {
  private ArrayList<B12Digit> digits;
  private int value;
  private PVector pos;
  private boolean arrayLoaded;
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
    for(int i = 0; i < digits.size(); i++){
      digits.get(i).display();
    }
    popMatrix();
  }
  
  private void positionDigits(){
    if(mode == LEFT || mode == DECIMAL){
      for(int i = 0; i < digits.size(); i++){
        digits.get(i).setRefPos((-12 * (i+1)), 0);
      }
    }else if(mode == RIGHT){
      int count = 0;
      for(int i = digits.size() - 1; i >= 0; i--){
        digits.get(count).setRefPos((12 * i) + 3, 0);
        count++;
      }
    }
    inPosition = true;
  }
  
  private void loadArray(){
    digits = new ArrayList<B12Digit>();
    int mval = abs(value);
    if(mval == 0){ digits.add(new B12Digit(0)); }
    while(mval != 0){
      if(mval < 12){
        digits.add(new B12Digit(mval));
        mval = 0;
      }else{
        digits.add(new B12Digit(mval % 12));
        mval /= 12;
      }
    }
    if(digits.size() < minLen){
      digits.add(new B12Digit(0));
    }
    if(value < 0){
      digits.add(new B12Digit('-'));
    }
    
    arrayLoaded = true;
  }
}




class B12Float implements Number{
  //private ArrayList<B12Digit> digits;
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
    mode = DECIMAL;
    places = 4;
  }
  
  float getValue(){ return value; }
  PVector getPos(){ return pos; }
  int getPlaces(){ return places; }
  B12Int toInt(){return new B12Int(int(value));}
  B12Digit[] getDigits(){  //<>//
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
  
  B12Float setValue(float _value){ value = _value; arrayLoaded = false; return this;}
  B12Float setPos(PVector _pos){ pos = _pos.copy(); inPosition = false;return this; }
  B12Float setPos(float _x, float _y){ pos = new PVector(_x, _y); inPosition = false;return this; }
  B12Float setPlaces(int _places){ 
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
  
  private void positionDigits(){
    int curPos = 0;
    int count = 0;
    if(mode == LEFT){
      for(int i = 0; i < pointPlace; i++){
        curPos += -12;
        digits[i].setRefPos(curPos, 0);
        count++;
      }
      
      curPos += -8;
      digits[count].setRefPos(curPos, 0);
      count++;
      curPos += -6;
      digits[count].setRefPos(curPos, 0);
      count++;
      
      for(int i = count; i < digits.length; i++){
        curPos += -12;
        digits[i].setRefPos(curPos, 0);
      }
    }else if(mode == DECIMAL){
      curPos = -5;
      digits[pointPlace].setRefPos(curPos,0);
      curPos += -2;
      for(int i = pointPlace - 1; i >= 0; i--){
        curPos += 12;
        digits[i].setRefPos(curPos,0);
      }
      curPos = -2;
      
      for(int i = pointPlace + 1; i < digits.length; i++){
        curPos += -12;
        digits[i].setRefPos(curPos,0);
      }
    }else if(mode == RIGHT){
      for(int i = digits.length - 1; i >= 0; i--){
        digits[count].setRefPos((12 * i) + 3, 0);
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
