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

class B12Expression {
  private B12Digit[] expression;
  
  B12Expression(){
    expression = new B12Digit[0];
  }
  
  // GETTERS //
  B12Digit getDigit(int index){ return expression[index]; }
  int length(){if(expression == null){return 0;} return expression.length;}
  
  // SETTERS //
  B12Expression insertChar(int ind, B12Digit _digit){
    expression = (B12Digit[])append(expression, _digit); // Add the new digit
    if(ind < expression.length - 1){ // Swap new digit
      for(int i = expression.length - 1; i > ind; i--){ // Start at second to last digit
        expression[i] = expression[i-1]; // Swap object one index below i up into index i
      }
      expression[ind] = _digit;
    }
    return this;
  }
  B12Expression addChar(B12Digit _digit){
    expression = (B12Digit[])append(expression, _digit);
    return this;
  }
  B12Expression delete(){
    expression = (B12Digit[])shorten(expression);
    return this;
  }
  
  B12Expression clear(){
    expression = new B12Digit[0];
    return this;
  }
  
  void evaluate(){
    String evalString = parseDigits();
    Expression exp = new ExpressionBuilder(evalString).build();
    expression = new B12Float((float)exp.evaluate()).setPlaces(12).getDigits();
    println(exp.evaluate());
    dbout = str((float)exp.evaluate());
  }
  
  private String parseDigits(){
    String valid = "+*-/"; // valid characters to accept
    String evalString = ""; // gets filled with the expression up for evaluation in base 10
    B12Digit[] cnum = new B12Digit[0]; // used to sum numbers as the array is parsed
    boolean cfs = false; // float status of currently building number
    
    
    // Parse expression[] into a base 10 string that can be evaluated mathematically
    if(!(expression[expression.length - 1].isNum() || expression[expression.length -1].getValue() == ')' )){throw new IllegalArgumentException("Invalid input");} // check that final character is a number
    for (int c = expression.length; c >= 0; c--){

      int i = c - 1;
      
      if (i == -1){ // At the end, add the final number if neccessary
        // add number to string if present
        if(cnum.length != 0 && cfs == false){
          B12Int num = (B12Int)convert(cnum,cfs);
          evalString = str(num.getValue()) + evalString; 
          cnum = new B12Digit[0];
        }
        else if(cnum.length != 0 && cfs == true){ 
          B12Float num = (B12Float)convert(cnum,cfs);
          evalString = str(num.getValue()) + evalString; 
          cnum = new B12Digit[0];
          cfs = false;
        }
        break;
      }
      
      // If there is no number currently being built and the current character is a number start building a new number
      if (expression[i].isNum() && cnum.length == 0){ 
        cnum = (B12Digit[])append(cnum,expression[i]);
      }
      // If the current character is a number and there IS a number currently being built add the character into the number
      else if (expression[i].isNum() && cnum.length != 0){
        cnum = (B12Digit[])append(cnum,expression[i]);
      }
      else if (expression[i].value == '.' && cnum.length != 0){
        if(cfs == true){throw new IllegalArgumentException("Invalid input");}
        cnum = (B12Digit[])append(cnum,expression[i]);
        cfs = true;
      }
      // If any other valid character just add it to the string after making sure to add the last built number if it exists
      else if (inStr(valid,char(expression[i].value))){
        
        // add number to string if present
        if(cnum.length != 0 && cfs == false){
          B12Int num = (B12Int)convert(cnum,cfs);
          evalString = str(num.getValue()) + evalString; 
          cnum = new B12Digit[0];
        }
        else if(cnum.length != 0 && cfs == true){ 
          B12Float num = (B12Float)convert(cnum,cfs);
          evalString = str(num.getValue()) + evalString; 
          cnum = new B12Digit[0];
          cfs = false;
        }
        
        // add character to string
        evalString = char(expression[i].getValue()) + evalString;
      }
      // In all other cases fail
      else{
        throw new IllegalArgumentException("Invalid input");
      }
    }
    
    return(evalString);
  }
  
  
  
  // HELPER FUNCTIONS //
  private Number convert(B12Digit[] cnum, boolean isFloat){
    if(!isFloat){
      int out = 0;
      for(int i = 0; i < cnum.length; i++){
        out += cnum[i].getValue() * pow(12,i);
      }
      return new B12Int(out);
    }
    
    // Else if float
    float out = 0;
    int pInd = 0; // Index of period
    while(true){// find index of period
      if(!cnum[pInd].isNum()){break;}
      pInd++;
    }
    B12Digit[] deci = (B12Digit[])reverse(subset(cnum,0,pInd));
    B12Digit[] whole = (B12Digit[])subset(cnum,pInd+1,cnum.length-pInd-1);
    for(int i = 0; i < deci.length; i++){
      out += (float(deci[i].getValue())/12) * pow(10,-i);
    }
    for(int i = 0; i < whole.length; i++){
      out += float(whole[i].getValue()) * pow(12,i);
    }
    return new B12Float(out);
  }
  
  boolean inStr(String st, char _c){
    try{
      int x = st.indexOf(_c);
      return true;
    }
    catch (Exception e){
      return false;
    }
  }
}

class MathDisplay {
  PVector pos;
  B12Expression ex;
  
  MathDisplay(B12Expression _ex){
    ex = _ex;
    pos = new PVector(0,0);
  }
  
  PVector getPos(){ return pos; }
  MathDisplay setPos(PVector _pos){ pos = _pos; return this;}
  
  void display(){
    pushMatrix();
    translate(pos.x,pos.y);
    int count = 0;
    for(int i = ex.length() - 1; i >= 0 ; i--){
      ex.getDigit(i).setPos((-12 * (count+1)), 0);
      ex.getDigit(i).display();
      count++;
    }
    popMatrix();
  }
}



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
    buttons = (Button[])append(buttons, new Button(mh).setText("Enter").setPos(new PVector(pos.x + 22*4,pos.y + 22*3)).setDim(new PVector(42,20)).setFunction(new MethodRelay(this.ex, "evaluate")).setColor(220,150));
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
      case CORNER: digit.setPos(super.dim.x/2 - 4, super.dim.y - 2);
    }
    
    digit.display();
    
    popMatrix();    
  }
}
