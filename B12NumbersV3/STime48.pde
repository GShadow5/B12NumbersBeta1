class STime48 extends Time48{
  int offset;
  int tmillis;
  private boolean synced;
  
  STime48(){
    super();
    offset = 0;
    tmillis = 0;
    synced = false;
    this.start();
  }

  boolean synced(){return synced;}
  public void syncTime(){ synced = false; } // Allows syncing after time starts running
  void setTime(Time48 _time){ 
    offset = _time.b10millis() - millis() - tmillis;
  }
  
  @Override
  public void run(){
    while(true){
      if(!synced){sync();}
      
      delay(1); // MUST USE DELAY OR OFFSET DOES NOT GET CALCULATED
      if(tmillis + millis() + offset > 86400000){ tmillis -= 86400000; } // Fall over at 00:00
      setTsec(int((tmillis + millis() + offset) / 1562.5));
    }
  }
  
  private void sync(){
    int sec = second();
    tmillis = 0;
    while(true){
      if(sec != second()){
        tmillis = second()*1000 + minute()*60*1000 + hour()*60*60*1000;
        synced = true;
        println("synced");
        break;
      }
    }
  }
}
