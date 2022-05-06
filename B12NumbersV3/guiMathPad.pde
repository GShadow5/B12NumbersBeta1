class MathPad{
  B12Expression ex;
  MouseHandler mh;
  B12Button[] buttons;
  PVector pos;
  
  MathPad(MouseHandler _mh, B12Expression _ex){
    ex = _ex;
    mh = _mh;
    pos = new PVector(0,0);
    buttons = new B12Button[12];
    initialize();
  }
  
  void initialize(){
    for(int i = 0; i < 12; i++){
      buttons[i] = new B12Button(mh, new PVector(25 * int(i%4),25 * floor(i/4)), new PVector(20,20),new B12Digit(i));
      buttons[i].setFunction(new MethodRelay(this, "addChar", B12Digit.class));
      buttons[i].setColor(220,150);
    }
  }

  // TODO send characters to display
  
  void addChar(B12Digit _digit){
    ex.addChar(_digit);
    println("clicked " + _digit.getValue());
  }
  
  void display(){
    pushMatrix();
    translate(pos.x,pos.y);
    for(int i = 0; i < 12; i++){
      buttons[i].display();
    }
    popMatrix();
  }
  
  
}

class B12Button extends Button{
  B12Digit digit;
  
  B12Button(MouseHandler _mh, PVector _pos, PVector _dim, float _radius, B12Digit _digit){
    super(_mh,_pos,_dim,_radius);
    //data = new Object[]{_digit}; Deprecated
    digit = _digit;
    setData(_digit);
  }
  B12Button(MouseHandler _mh, PVector _pos, PVector _dim, B12Digit _digit){
    this(_mh, _pos, _dim, 2, _digit);
  }
  
  // GETTERS AND SETTERS //
  B12Digit getDigit(){ return digit; }
  void setDigit(B12Digit _digit){ digit = _digit; }
  
  @Override
  void display(){
    super.display(); //<>//
    
    pushMatrix();
    
    translate(super.pos.x,super.pos.y);
    switch(super.mode){
      case CORNER: digit.setRefPos(super.dim.x/2 - 4, super.dim.y - 2);
    }
    
    digit.display();
    
    popMatrix();    
  }
}
