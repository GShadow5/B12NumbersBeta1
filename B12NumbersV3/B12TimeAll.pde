class Time48 extends Thread{
  private int sec48;
  private int min48;
  private int hour48;
  private int tsec48; // Total seconds
  private boolean initialized;
  
   // CONSTRUCTORS //
   // TODO add throwing exceptions to all contructors
  Time48(){
    sec48 = 0;
    min48 = 0;
    hour48 = 0;
    tsec48 = 0;
    initialized = false;
  }
  
  Time48(int _tsec48){
    tsec48 = _tsec48;
    flattenTSec();
    initialized = true;
  }
  
  Time48(Time48 t48){
    tsec48 = t48.tsec();
    flattenTSec();
    initialized = true;
  }
  
  Time48(int h, int m, int s){
    if(h >= 0 && h < 24){ hour48 = h;}else{throw new IllegalArgumentException();}
    if(m >= 0 && m < 48){ min48 = m;}else{throw new IllegalArgumentException();}
    if(s >= 0 && s < 48){ sec48 = s;}else{throw new IllegalArgumentException();}
    flattenOther();
    initialized = true;
  }
  
  // GETTERS //
  int hours(){return hour48;}
  int mins(){return min48;}
  int secs(){return sec48;}
  int tsec(){return tsec48;}
  int[] t48(){int[] out = {hour48,min48,sec48}; return out;}
  boolean initialized(){return initialized;}
  int b10millis(){return int(float(tsec48) * 1562.5);}

  Time48 copy(){ return new Time48(this); }
  
  // SETTERS //
  Time48 setHour(int h){
    if(h < 0 || h >= 24) throw new IllegalArgumentException();
    hour48 = h;
    flattenOther();
    initialized = true;
    return this;
  }
  Time48 setMin(int m){
    if(m < 0 || m >= 48) throw new IllegalArgumentException();
    min48 = m;
    flattenOther();
    initialized = true;
    return this;
  }
  Time48 setSec(int s){
    if(s < 0 || s >= 48) throw new IllegalArgumentException();
    sec48 = s;
    flattenOther();
    initialized = true;
    return this;
  }
  Time48 setTsec(int s){ // TODO add exception
    tsec48 = s;
    flattenTSec();
    initialized = true;
    return this;
  }
  
  // PRIVATE FUNCTIONS //
  private void flattenTSec(){
    sec48 = tsec48;
    min48 = sec48 / 48;
    hour48 = min48 / 48;
    
    sec48 -= min48 * 48;
    min48 -= hour48 * 48;
  }
  private void flattenOther(){
    tsec48 = hour48*48*48 + min48*48 + sec48;
  }
  
  
  // PLACEHOLDER FUNCTIONS //
  public void run(){}
}



class STime48 extends Time48{
  private int offset; // Time offset in milliseconds
  private int tmillis; // Actual time at which time was synced to real world in milliseconds
  private int syncedat; // Offset between the start of the program (when millis() starts counting from) and when the time was last synced
  private boolean synced;
  
  STime48(){
    super();
    offset = 0;
    tmillis = 0;
    syncedat = 0;
    synced = false;
    this.start();
  }

  // Public sync functions
  public boolean synced(){return synced;}
  public STime48 syncTime(){ synced = false; return this; } // Allows syncing after time starts running
  public STime48 setTime(Time48 _time){
    // To get offset we subtract where the current clock is from where we want it to be
    offset = _time.b10millis() - millis() - tmillis + syncedat;
    return this;
  }
  
  // Threaded code
  @Override
  public void run(){
    while(true){
      if(!synced){sync();}
      
      delay(1); // MUST USE DELAY OR OFFSET DOES NOT GET CALCULATED
      if(tmillis + millis() + offset > 86400000){ tmillis -= 86400000; } // Fall over at 00:00
      setTsec(int((tmillis + millis() - syncedat + offset) / 1562.5)); // Add time at sync, millis since program start, and offset, and subtract the millis between program start and sync (because we're adding millis())
    }
  }
  
  // Initial sync code
  private void sync(){
    int sec = second();
    tmillis = 0;
    while(true){
      if(sec != second()){ // Wait until seconds changes so as to be as accurate as possible
        tmillis = second()*1000 + minute()*60*1000 + hour()*60*60*1000; // Current time in total millis
        syncedat = millis();
        synced = true;
        println("synced");
        break;
      }
    }
  }
}




class Clock {
  PVector pos;
  STime48 t48;
  B12Int hours;
  B12Int minutes;
  B12Int seconds;
  B12Digit sep; // TODO Just deprecated B12Char. Refactor to single array of B12Digits?
  int tmillis;

  Clock(STime48 _t48) {
    pos = new PVector(0, 0);
    t48 = _t48;
    hours = new B12Int(t48.hours());
    minutes = new B12Int(t48.mins());
    seconds = new B12Int(t48.secs());
    sep = new B12Digit(':'); // Seperation character between time columns

    hours.setMinLen(2); 
    minutes.setMinLen(2); // Format all the ints to show a 0 in the 12s column if they are less than 12
    seconds.setMinLen(2);
  }

  // GETTERS and SETTERS //
  PVector getPos() { return pos; }
  Clock setPos(PVector _pos) { pos = _pos.copy(); return this;}
  Clock setPos(float _x, float _y) { pos = new PVector(_x, _y);return this;}

  Clock setTime(Time48 _time) { t48.setTime(_time); return this;}
  Clock resetTime() { t48.setTime(new Time48(0)); return this;}

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
    } else {
      text("fetching current time", pos.x, pos.y);
    }
  }
}
