class B12Digit{
  byte value;
  PVector refPos;
  
  B12Digit(int _value){
    if(_value >= 12 || _value < 0){ 
      throw new IllegalArgumentException("B12Digit only accepts decimal integers 0 through 11 -- " + _value); 
    }
    value = byte(_value);
    refPos = new PVector(0,0);
  }
  
  B12Digit(char _c){
    String valid = "+-*/.:"; // Defines valid input characters
    if(!inStr(valid, _c)){ throw new IllegalArgumentException("B12Char only accepts \'+ - * / . :'"); }
    value = byte(_c);
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



class B12Int {
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
  
  int getValue(){ return value; }
  void setValue(int _value){ value = _value; arrayLoaded = false; }
  
  void setPos(PVector _pos){ pos = _pos.copy(); inPosition = false; }
  void setPos(float _x, float _y){ pos = new PVector(_x, _y); inPosition = false; }
  PVector getPos(){ return pos; }
  
  void setMinLen(int i){ minLen = i; }
  
  void setAlignMode(int _mode){
    if(_mode == DECIMAL || _mode == LEFT || _mode == RIGHT){ mode = _mode; }
    else{ println("Alignment only accepts LEFT, RIGHT, and DECIMAL"); }
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




class B12Float {
  private ArrayList<B12Digit> digits;
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
  void setValue(float _value){ value = _value; arrayLoaded = false; }
  
  PVector getPos(){ return pos; }
  void setPos(PVector _pos){ pos = _pos.copy(); inPosition = false; }
  void setPos(float _x, float _y){ pos = new PVector(_x, _y); inPosition = false; }
  
  int getPlaces(){ return places; }
  void setPlaces(int _places){ 
    if(_places > 12 || _places < 0){ 
      throw new IllegalArgumentException("B12Float ncan only display to 12 duodecimal points");
    }else{
      places = _places;
    }
  }
  
  void setAlignMode(int _mode){
    if(_mode == DECIMAL || _mode == LEFT || _mode == RIGHT){ mode = _mode; }
    else{ println("Alignment only accepts LEFT, RIGHT, and DECIMAL"); }
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
    int curPos = 0;
    int count = 0;
    if(mode == LEFT){
      for(int i = 0; i < pointPlace; i++){
        curPos += -12;
        digits.get(i).setRefPos(curPos, 0);
        count++;
      }
      
      curPos += -8;
      digits.get(count).setRefPos(curPos, 0);
      count++;
      curPos += -6;
      digits.get(count).setRefPos(curPos, 0);
      count++;
      
      for(int i = count; i < digits.size(); i++){
        curPos += -12;
        digits.get(i).setRefPos(curPos, 0);
      }
    }else if(mode == DECIMAL){
      curPos = -5;
      digits.get(pointPlace).setRefPos(curPos,0);
      curPos += -2;
      for(int i = pointPlace - 1; i >= 0; i--){
        curPos += 12;
        digits.get(i).setRefPos(curPos,0);
      }
      curPos = -2;
      
      for(int i = pointPlace + 1; i < digits.size(); i++){
        curPos += -12;
        digits.get(i).setRefPos(curPos,0);
      }
    }else if(mode == RIGHT){
      for(int i = digits.size() - 1; i >= 0; i--){
        digits.get(count).setRefPos((12 * i) + 3, 0);
        count++;
      }
    }
    inPosition = true;
  }
  
  private void loadArray(){
    digits = new ArrayList<B12Digit>();
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
      digits.add(temp[i]);
    }
    
    pointPlace = digits.size();
    digits.add(new B12Digit('.'));
    
    while(whole > 0){
      if(whole < 12){
        digits.add(new B12Digit(whole));
        whole = 0;
      }else{
        digits.add(new B12Digit(whole % 12));
        whole /= 12;
      }
    }
    
    if(value < 0){
      digits.add(new B12Digit('-'));
    }
    
    arrayLoaded = true;
    inPosition = false;
  }
}
