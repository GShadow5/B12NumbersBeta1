class B12Char extends B12Digit{
  char c;
  
  B12Char(char _c){
    super(0);
    if(_c == '-' || _c == '.' || _c == ':'){
      c = _c;
    }else{ 
      throw new IllegalArgumentException("B12Char only accepts \'-\', \'.\', and ':'"); 
    }
  }
  
  @Override 
  void display(){
    pushMatrix();
    translate(refPos.x,refPos.y);
    strokeWeight(1);
    
    switch(c) {
      case '-':
        lineMinus(); break;
      case '.':
        strokeWeight(2); period(); break;
      case ':':
        strokeWeight(2); colon(); break;
    }
    
    popMatrix();
  }
  
  void lineMinus(){ line(3,-5,9,-5); }
  void period(){ point(5,0); }
  void colon(){ point(5,-2); point(5,-8); }
}
