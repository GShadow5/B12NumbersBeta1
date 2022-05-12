class MathPad{
  private B12Expression ex;
  private MouseHandler mh;
  private Button[] buttons;
  private PVector pos;
  
  MathPad(MouseHandler _mh, B12Expression _ex){
    ex = _ex;
    mh = _mh;
    pos = new PVector(0,0);
    buttons = new Button[0];
    initialize();
  }
  
  // GETTERS AND SETTERS //
  PVector getPos(){return pos;}
  MathPad setPos(PVector _pos){
    pos = _pos.copy(); 
    initialize(); 
    return this;
  }
  
  
  void initialize(){
    buttons = new Button[0];
    // Create numpad buttons
    for(int i = 0; i < 12; i++){
      /* Button position must contain it's absolute position relative to sketch 0,0 for mouseOver to work. 
         This means we cannot translate and traw buttons, we mumst factor the parents position into the
         absolute position of the button */
      // x = pos.x + (width + gap) * (i%cols)
      // y = pos.y + (height + gap) * b2rows - (height + gap) * row
      PVector bPos = new PVector(pos.x + 22 * int(i%4),pos.y + 22 * 3 - 22 * floor(i/4));
      buttons = (Button[])append(buttons, new B12Button(mh ,new B12Digit(i)).setPos(bPos).setDim(new PVector(20,20)).setFunction(new MethodRelay(this, "addChar", B12Digit.class)).setColor(220,150));
    }
    // Create other buttons
    buttons = (Button[])append(buttons, new B12Button(mh, new B12Digit('(')).setPos(new PVector(pos.x,pos.y)).setFunction(new MethodRelay(this, "addChar", B12Digit.class)).setColor(220,150));
    buttons = (Button[])append(buttons, new B12Button(mh, new B12Digit(')')).setPos(new PVector(pos.x + 22,pos.y)).setFunction(new MethodRelay(this, "addChar", B12Digit.class)).setColor(220,150));
    buttons = (Button[])append(buttons, new B12Button(mh, new B12Digit('+')).setPos(new PVector(pos.x + 22*2,pos.y)).setFunction(new MethodRelay(this, "addChar", B12Digit.class)).setColor(220,150));
    buttons = (Button[])append(buttons, new B12Button(mh, new B12Digit('-')).setPos(new PVector(pos.x + 22*3,pos.y)).setFunction(new MethodRelay(this, "addChar", B12Digit.class)).setColor(220,150));
    buttons = (Button[])append(buttons, new B12Button(mh, new B12Digit('*')).setPos(new PVector(pos.x + 22*4,pos.y)).setFunction(new MethodRelay(this, "addChar", B12Digit.class)).setColor(220,150));
    buttons = (Button[])append(buttons, new B12Button(mh, new B12Digit('/')).setPos(new PVector(pos.x + 22*4,pos.y + 22)).setFunction(new MethodRelay(this, "addChar", B12Digit.class)).setColor(220,150));
    buttons = (Button[])append(buttons, new B12Button(mh, new B12Digit('.')).setPos(new PVector(pos.x + 22*4,pos.y + 22*2)).setFunction(new MethodRelay(this, "addChar", B12Digit.class)).setColor(220,150));
    buttons = (Button[])append(buttons, new Button(mh).setText("Enter").setPos(new PVector(pos.x + 22*4,pos.y + 22*3)).setDim(new PVector(42,20)).setFunction(new MethodRelay(this.ex, "evaluate")).setColor(220,150)); //<>//
    buttons = (Button[])append(buttons, new Button(mh).setText("Cl").setPos(new PVector(pos.x + 22*5,pos.y + 22)).setDim(new PVector(20,42)).setFunction(new MethodRelay(this.ex, "clear")).setColor(220,150));
    buttons = (Button[])append(buttons, new Button(mh).setText("Del").setPos(new PVector(pos.x + 22*5,pos.y)).setDim(new PVector(20,20)).setFunction(new MethodRelay(this.ex, "delete")).setColor(220,150));
  }
  
  void addChar(B12Digit _digit){
    ex.addChar(_digit);
  }
  
  void display(){
    for(int i = 0; i < buttons.length; i++){
      buttons[i].display();
    }
  }
}



class B12Button extends Button{
  B12Digit digit;
  
  B12Button(MouseHandler _mh, B12Digit _digit){
    super(_mh);
    digit = _digit;
    setData(_digit);
  }
  
  // GETTERS AND SETTERS //  
  B12Digit getDigit(){ return digit; }
  B12Button setDigit(B12Digit _digit){ digit = _digit; return this; }
  
  // Add drawing the B12Digit to the display method
  @Override
  void display(){
    super.display();
    
    pushMatrix();
    
    translate(super.pos.x,super.pos.y);
    switch(super.mode){
      case CORNER: digit.setRefPos(super.dim.x/2 - 4, super.dim.y - 2);
    }
    
    digit.display();
    
    popMatrix();    
  }
}
