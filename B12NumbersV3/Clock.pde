class Clock {
  PVector pos;
  STime48 t48;
  B12Int hours;
  B12Int minutes;
  B12Int seconds;
  B12Digit sep;
  B12Int fill;
  int tmillis;
  //boolean initialized;

  Clock(STime48 _t48) { // TODO refactor time class
    pos = new PVector(0, 0);
    t48 = _t48;
    hours = new B12Int(t48.hours());
    minutes = new B12Int(t48.mins());
    seconds = new B12Int(t48.secs());
    sep = new B12Digit(':');
    fill = new B12Int(0);

    hours.setMinLen(2);
    minutes.setMinLen(2);
    seconds.setMinLen(2);
  }

  PVector getPos() { 
    return pos;
  }
  void setPos(PVector _pos) { 
    pos = _pos.copy();
  }
  void setPos(float _x, float _y) { 
    pos = new PVector(_x, _y);
  }

  void setTime(Time48 _time) {
    t48.setTime(_time);
    //initialized = true;
  }

  //public void syncTime(){ initialized = false; } // Allows syncing after time starts running

  void display() {
    if (t48.synced()) {
      // Time
      hours.setValue(t48.hours());
      minutes.setValue(t48.mins());
      seconds.setValue(t48.secs());

      // Position
      hours.setPos(-64, 0);
      minutes.setPos(-32, 0);
      seconds.setPos(0, 0);
      B12Digit c1 = new B12Digit(':');
      B12Digit c2 = new B12Digit(':');
      c1.setRefPos(-34, 0);
      c2.setRefPos(-66, 0);

      // Display
      pushMatrix();
      translate(pos.x, pos.y);
      hours.display();
      c2.display();
      minutes.display();
      c1.display();
      seconds.display();
      popMatrix();
      //print(seconds.getValue());
    } else {
      text("fetching current time", pos.x, pos.y);
    }
  }
}
