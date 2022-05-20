class B12Button extends Button{
  /*
      A button that can render a B12Digit instead of text
  */
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
      case CORNER: digit.setPos(super.dim.x/2 - 4, super.dim.y - 2);
    }
    
    digit.display();
    
    popMatrix();    
  }
}
