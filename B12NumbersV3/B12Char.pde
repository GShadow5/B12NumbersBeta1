class B12Char extends B12Digit{
  String valid;
  char c;
  
  B12Char(char _c){
    super(0);
    valid = "+-*/.:"; // Defines valid input characters
    if(inStr(_c)){
      c = _c;
    }else{ 
      throw new IllegalArgumentException("B12Char only accepts \'+ - * / . :'"); 
    }
  }
  
  @Override 
  void display(){
    pushMatrix();
    translate(refPos.x,refPos.y);
    strokeWeight(1);
    
    switch(c) {
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
  
  void lineTimes(){ line(4,-7,8,-3); line(4,-3,8,-7); }
  void dotsDiv(){ point(6,-8); point(6,-2); }
  void lineMinus(){ line(3,-5,9,-5); }
  void linePlus(){ line(6,-8,6,-2); }
  void period(){ point(5,0); }
  void colon(){ point(5,-2); point(5,-8); }
  
  boolean inStr(char _c){
    try{
      int x = valid.indexOf(_c);
      return true;
    }
    catch (Exception e){
      return false;
    }
  }
}
