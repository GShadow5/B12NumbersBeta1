class Calculator{
  B12Expression ex;
  MathPad m;
  MathDisplay d;
  
  Calculator(ClickHandler _ch){
    ex = new B12Expression();
    m = new MathPad(_ch,ex);
    d = new MathDisplay(ex);
  }
  
  void display(){
    m.display();
    d.display();
  }
}
