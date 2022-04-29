class Time48 extends Thread{
  private int sec48;
  private int min48;
  private int hour48;
  private int tsec48;
  private boolean initialized;
  
   // CONSTRUCTORS //
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
  
  Time48 offset(Time48 t){
    return new Time48(t.tsec() + tsec48);
  }
  
  Time48 copy(){ return new Time48(this); }
  
  // SETTERS //
  void setHour(int h){
    if(h < 0 || h >= 24) throw new IllegalArgumentException();
    hour48 = h;
    flattenOther();
    initialized = true;
  }
  void setMin(int m){
    if(m < 0 || m >= 48) throw new IllegalArgumentException();
    min48 = m;
    flattenOther();
    initialized = true;
  }
  void setSec(int s){
    if(s < 0 || s >= 48) throw new IllegalArgumentException();
    sec48 = s;
    flattenOther();
    initialized = true;
  }
  void setTsec(int s){
    tsec48 = s;
    flattenTSec();
    initialized = true;
  }
  
  // PRIVATE FUNCTIONS //
  private void flattenTSec(){
    sec48 = tsec48;
    min48 = sec48 / 48;
    hour48 = min48 / 48;
    
    sec48 -= min48 * 48;
    min48 -= hour48 * 48;
    //println(t48());
  }
  private void flattenOther(){
    tsec48 = hour48*48*48 + min48*48 + sec48;
  }
  
  
  // PLACEHOLDER FUNCTIONS //
  public void run(){}
}
