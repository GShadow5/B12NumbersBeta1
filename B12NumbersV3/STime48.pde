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
  public void syncTime(){ synced = false; } // Allows syncing after time starts running
  public void setTime(Time48 _time){
    // To get offset we subtract where the current clock is from where we want it to be
    offset = _time.b10millis() - millis() - tmillis + syncedat;
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
