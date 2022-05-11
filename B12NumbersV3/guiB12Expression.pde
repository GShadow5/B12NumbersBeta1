class B12Expression {
  private B12Digit[] expression;
  
  B12Expression(){
    expression = new B12Digit[0];
  }
  
  B12Digit getDigit(int index){ return expression[index]; }
  int length(){return expression.length;}
  
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
  
  void evaluate(){
    String valid = "+*-/"; // valid characters to accept
    String evalString = ""; // gets filled with the expression up for evaluation in base
    Number cnum = null; // used to sum numbers as the array is parsed
    int count = 0; // counts what column we're at for multiplying base 12 to base 10
    
    
    // Parse expression[] into a base 10 string that can be evaluated mathematically
    if(!expression[expression.length - 1].isNum()){throw new IllegalArgumentException("Invalid input");} // check that final character is a number
    for (int c = expression.length; c >= 0; c--){
      int i = c - 1;
      
      if (i == -1){ // At the end, add the final number if neccessary //<>//
        // add number to string if present
        if(cnum != null && cnum.getClass() == B12Int.class){
          B12Int t = (B12Int)cnum;
          evalString = evalString + str(t.getValue()); 
          cnum = null;
        }
        else if(cnum != null && cnum.getClass() == B12Float.class){ 
          B12Float t = (B12Float)cnum;
          evalString = evalString + str(t.getValue()); 
          cnum = null;
        }
        break;
      }
      
      // If there is no number currently being built and the current character is a number start building a new number
      if (expression[i].isNum() && cnum == null){ 
        count = 0;
        cnum = new B12Int(int(expression[i].getValue()));
      }
      // If the current character is a number and there IS a number currently being built add the character into the number
      else if (expression[i].isNum() && cnum != null){
        count += 1;
        cnum = cnum.addn(new B12Int(int(expression[i].getValue() * (pow(12,count)))));
      }
      // If we run into a period and are currently building an int, switch to float and make current number the decimal. (MAY BE BROKEN)
      else if (expression[i].value == '.' && cnum != null && cnum.getClass() == B12Int.class){
        B12Int temp = (B12Int)cnum;
        //float f = float("." + str((B12Int)cnum.getValue()));
        cnum = new B12Float(float("." + str(temp.getValue())));
      }
      // If any other valid character just add it to the string after making sure to add the last built number if it exists
      else if (inStr(valid,char(expression[i].value))){
        // reset number digit multiplier count
        count = 0; 
        
        // add number to string if present
        if(cnum != null && cnum.getClass() == B12Int.class){
          B12Int t = (B12Int)cnum;
          evalString = evalString + str(t.getValue()); 
          cnum = null;
        }
        if(cnum != null && cnum.getClass() == B12Float.class){ 
          B12Float t = (B12Float)cnum;
          evalString = evalString + str(t.getValue()); 
          cnum = null;
        }
        
        // add character to string
        evalString = evalString + char(expression[i].getValue());
      }
      // In all other cases fail
      else{
        throw new IllegalArgumentException("Invalid input");
      }
    }
    
    println(evalString);
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
