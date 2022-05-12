class B12Expression {
  private B12Digit[] expression;
  
  B12Expression(){
    expression = new B12Digit[0];
  }
  
  // GETTERS //
  B12Digit getDigit(int index){ return expression[index]; }
  int length(){return expression.length;}
  
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
    //db println("evaluate"); //<>//
    String valid = "+*-/"; // valid characters to accept
    String evalString = ""; // gets filled with the expression up for evaluation in base 10
    B12Digit[] cnum = new B12Digit[0]; // used to sum numbers as the array is parsed
    boolean cfs = false; // float status of currently building number
    //int count = 0; // counts what column we're at for multiplying base 12 to base 10
    
    
    // Parse expression[] into a base 10 string that can be evaluated mathematically
    if(!(expression[expression.length - 1].isNum() || expression[expression.length -1].getValue() == ')' )){throw new IllegalArgumentException("Invalid input");} // check that final character is a number
    //db println("final char is valid");
    for (int c = expression.length; c >= 0; c--){
      //db println("top of for loop " + c);
      int i = c - 1;
      
      if (i == -1){ // At the end, add the final number if neccessary //<>//
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
      //db println("passed finish clause loop " + c);
      // If there is no number currently being built and the current character is a number start building a new number
      if (expression[i].isNum() && cnum.length == 0){ 
        //count = 0;
        cnum = (B12Digit[])append(cnum,expression[i]);
      }
      // If the current character is a number and there IS a number currently being built add the character into the number
      else if (expression[i].isNum() && cnum.length != 0){
        //count += 1;
        cnum = (B12Digit[])append(cnum,expression[i]);
      }
      else if (expression[i].value == '.' && cnum.length != 0){
        if(cfs == true){throw new IllegalArgumentException("Invalid input");}
        cnum = (B12Digit[])append(cnum,expression[i]);
        cfs = true;
      }
      // If any other valid character just add it to the string after making sure to add the last built number if it exists
      else if (inStr(valid,char(expression[i].value))){
        // reset number digit multiplier count
        //count = 0; 
        
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
        //db println("throwing exception");
        throw new IllegalArgumentException("Invalid input");
      }
    }
    
    println(evalString);
  }
  private Number convert(B12Digit[] cnum, boolean isFloat){
    if(!isFloat){
      int out = 0;
      //cnum = (B12Digit[])reverse(cnum);
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
  
  // HELPER FUNCTIONS //
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
