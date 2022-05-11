class MathPad{
  B12Expression ex;
  MouseHandler mh;
  Button[] buttons;
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
      /* Button position must contain it's absolute position relative to sketch 0,0 for mouseOver to work. 
         This means we cannot translate and traw buttons, we mumst factor the parents position into the
         absolute position of the button */
      // x = pos.x + (width + gap) * (i%cols)
      // y = pos.y + (height + gap) * b2rows - (height + gap) * row
      PVector bPos = new PVector(pos.x + 22 * int(i%4),pos.y + 22 * 2 - 22 * floor(i/4));
      buttons[i] = new B12Button(mh ,new B12Digit(i)).setPos(bPos).setDim(new PVector(20,20)).setFunction(new MethodRelay(this, "addChar", B12Digit.class)).setColor(220,150);
    }
  }

  // DONE send characters to display
  
  void addChar(B12Digit _digit){
    ex.addChar(_digit);
    //println("clicked " + _digit.getValue());
  }
  
  void display(){
    pushMatrix();
    //translate(pos.x,pos.y);
    for(int i = 0; i < 12; i++){
      buttons[i].display();
    }
    popMatrix();
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
  
  // Add the B12Digit to the display method
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
