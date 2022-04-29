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
      digits.add(new B12Char('-'));
    }
    
    arrayLoaded = true;
  }
}
