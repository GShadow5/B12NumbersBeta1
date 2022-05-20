class STime48 extends Time48{
  /*  Synced time class which uses a seperate thread to update time
  */
  private int offset; // Time offset in milliseconds. Used to set STime48 to something other than machine time
  private int tmillis; // Actual time at which time was synced to real world in milliseconds.
  private int syncedat; // Offset between the start of the program (when millis() starts counting from) and when the time was last synced
  private boolean synced; // Stores STime48 status
  
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
  public STime48 syncTime(){ synced = false; return this; } // Allows re-syncing after time starts running
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
      
      delay(1); // MUST USE DELAY OR OFFSET DOES NOT GET CALCULATED - probably caused by some annoying simultaneous memory access glitch
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
