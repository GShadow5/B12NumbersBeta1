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
    for(int i = 0; i < 12; i++){
      buttons[i] = new B12Button(ch, new PVector(25 * int(i%4),25 * floor(i/4)), new PVector(20,20),new B12Digit(i));
      buttons[i].setFunction(new MethodRelay(this, "addChar", B12Digit.class));
      buttons[i].setColor(220,150);
    }
  }
  // DONE draw a grid for buttons
  // DONE draw characters in grid
  // DONE detect mousepresses on the buttons (maybe a global mouse handler?)
  // TODO send characters to math
  
  void addChar(B12Digit digit){
    //math.addChar(digit);
    //math.expression.add(new B12Char('/'));
    println("clicked " + digit.getValue());
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
    data = new Object[]{_digit}; //(Object[])append(data, _digit); commented version deprecated. required initializing array in Button
    digit = _digit;
  }
  B12Button(ClickHandler _ch, PVector _pos, PVector _dim, B12Digit _digit){
    this(_ch, _pos, _dim, 2, _digit);
  }
  
  // GETTERS AND SETTERS //
  B12Digit getDigit(){ return digit; }
  void setDigit(B12Digit _digit){ digit = _digit; }
  
  /*
  @Override
  void clicked(float x, float y){
    if(mouseOver){
      new MethodRelay(target, "addChar", B12Digit.class).execute(digit);
    }
  }*/
  
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
