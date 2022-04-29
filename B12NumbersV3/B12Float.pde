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
