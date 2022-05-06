class B12Expression {
  private B12Digit[] expression;
  
  B12Expression(){
    expression = new B12Digit[0];
  }
  
  B12Digit getDigit(int index){ return expression[index]; }
  int length(){return expression.length;}
  
  void setChar(int ind, B12Digit _digit){
    expression = (B12Digit[])append(expression, _digit); // Add the new digit
    if(ind < expression.length - 1){ // Swap new digit
      for(int i = expression.length - 1; i > ind; i--){ // Start at second to last digit
        expression[i] = expression[i-1]; // Swap object one index below i up into index i
      }
      expression[ind] = _digit;
    }
  }
  
  void addChar(B12Digit _digit){
    expression = (B12Digit[])append(expression, _digit);
  }
  
  void evaluate(){
    //TODO set expression to evaluation of expression
  }
}
