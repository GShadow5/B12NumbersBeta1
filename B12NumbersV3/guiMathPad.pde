class MathPad{
  B12Math math;
  ClickHandler ch;
  B12Button[] buttons;
  PVector pos;
  
  MathPad(ClickHandler _ch, B12Math _math){
    math = _math;
    ch = _ch;
    pos = new PVector(0,0);
    buttons = new B12Button[12];
    initialize();
  }
  
  void initialize(){
    int count = 11;
    for(int i = 0; i < 12; i++){
      buttons[i] = new B12Button(ch, new PVector(25 * int(i%4),25 * floor(i/4)), new PVector(20,20),new B12Digit(i));
      buttons[i].setColor(220,150);
    }
  }
  // TODO draw a grid for buttons
  // TODO draw characters in grid
  // TODO detect mousepresses on the buttons (maybe a global mouse handler?)
  // TODO send characters to math
  
  void addchar(){
    //math.expression.add(new B12Char('/'));
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
  
  B12Button(ClickHandler _ch, PVector _pos, PVector _dim, float _radius, B12Digit _digit){
    super(_ch,_pos,_dim,_radius);
    digit = _digit;
  }
  B12Button(ClickHandler _ch, PVector _pos, PVector _dim, B12Digit _digit){
    this(_ch, _pos, _dim, 2, _digit);
  }
  
  // GETTERS AND SETTERS //
  B12Digit getDigit(){ return digit; }
  void setDigit(B12Digit _digit){ digit = _digit; }
  
  @Override
  void display(){
    super.display(); //<>//
    //new MethodRelay(this, "mouseOver" + str(mode), float.class, float.class).execute(mouseX,mouseY);
    
    pushMatrix();
    
    translate(pos.x,pos.y);
    switch(mode){
      case CORNER: digit.setRefPos(dim.x/2 - 4,dim.y - 2);
    }
    
    digit.display();
    
    popMatrix();    
  }
}
