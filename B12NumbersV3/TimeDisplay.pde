class TimeDisplay {
  PVector pos;
  Time48 t48;
  B12Int hours;
  B12Int minutes;
  B12Int seconds;
  B12Digit[] digits;
  int tmillis;
  color col;

  TimeDisplay(Time48 _t48) {
    pos = new PVector(0, 0);
    t48 = _t48;
    hours = new B12Int(t48.hours());
    minutes = new B12Int(t48.mins());
    seconds = new B12Int(t48.secs());
    //sep = new B12Digit(':'); // Seperation character between time columns

    hours.setMinLen(2); 
    minutes.setMinLen(2); // Format all the ints to show a 0 in the 12s column if they are less than 12
    seconds.setMinLen(2);
  }

  // GETTERS and SETTERS //
  PVector getPos() { return pos; }
  Time48 getTime(){return t48;}
  color getCol(){return col;}
  TimeDisplay setPos(PVector _pos) { pos = _pos.copy(); return this;}
  TimeDisplay setPos(float _x, float _y) { pos = new PVector(_x, _y);return this;}
  TimeDisplay setCol(color _col){col = _col; return this;}

  TimeDisplay setTime(Time48 _time) {
    if(_time.getClass() == STime48.class){
      t48 = _time;
      return this;
    }
    t48 = _time.copy();
    return this;
  }
  
  TimeDisplay resetTime(){ // TODO test this. does it work?
    if(t48.getClass() != STime48.class){ println("Cannot reset a static time"); return this;}
    t48 = ((STime48)t48).setTime(new Time48(0));
    return this;
  }

  void display() {
    digits = new B12Digit[0];
    if(t48.getClass() == STime48.class){
      while(!((STime48)t48).synced()){text("fetching current time", pos.x, pos.y);}
    }
    // Time
    hours.setValue(t48.hours());
    minutes.setValue(t48.mins());
    seconds.setValue(t48.secs());
    
    digits = (B12Digit[])concat(digits,seconds.getDigits());
    digits = (B12Digit[])append(digits,new B12Digit(':'));
    digits = (B12Digit[])concat(digits,minutes.getDigits());
    digits = (B12Digit[])append(digits,new B12Digit(':'));
    digits = (B12Digit[])concat(digits,hours.getDigits());
    
    
    // Position
    for(int i = 0; i < digits.length; i++){
      digits[i].setPos(i*-13 + pos.x - 13,pos.y).setCol(col).display();
    }

    // Position
    /*
    hours.setPos(-64, 0);
    minutes.setPos(-32, 0);
    seconds.setPos(0, 0);
    B12Digit c1 = new B12Digit(':');
    B12Digit c2 = new B12Digit(':');
    c1.setPos(-34, 0);
    c2.setPos(-66, 0);

    // Display
    pushMatrix();
    translate(pos.x, pos.y);
    hours.display();
    c2.display();
    minutes.display();
    c1.display();
    seconds.display();
    popMatrix();*/
  }
}
