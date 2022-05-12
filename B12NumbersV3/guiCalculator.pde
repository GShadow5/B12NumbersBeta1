class Calculator{
  B12Expression ex;
  MathPad m;
  MathDisplay d;
  
  Calculator(MouseHandler _mh, B12Expression _ex){
    ex = _ex;
    m = new MathPad(_mh, ex).setPos(new PVector(-40,0));
    d = new MathDisplay(ex);
  }
  
  void display(){
    rect(85,-22,1,14);
    d.setPos(new PVector(83,-10));
    m.display();
    d.display();
  }
}
