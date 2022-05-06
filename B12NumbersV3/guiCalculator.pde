class Calculator{
  B12Expression ex;
  MathPad m;
  MathDisplay d;
  
  Calculator(MouseHandler _mh){
    ex = new B12Expression();
    m = new MathPad(_mh, ex);
    d = new MathDisplay(ex);
  }
  
  void display(){
    m.display();
    d.display();
  }
}
