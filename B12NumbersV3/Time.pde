/*class Time extends Thread{
  PVector pos;
  B12Int hours;
  B12Int minutes;
  B12Int seconds;
  B12Char sep;
  B12Int fill;
  int tmillis;
  boolean initialized;
  
  Time(Time48 t48){ // TODO refactor time class
    pos = new PVector(0,0);
    hours = new B12Int(0);
    minutes = new B12Int(0);
    seconds = new B12Int(0);
    sep = new B12Char(':');
    fill = new B12Int(0);
    
    hours.setMinLen(2);
    minutes.setMinLen(2);
    seconds.setMinLen(2);
    
    initialized = false;
    this.start();
    //thread("this.runTime");
  }
  
  PVector getPos(){ return pos; }
  void setPos(PVector _pos){ pos = _pos.copy(); }
  void setPos(float _x, float _y){ pos = new PVector(_x,_y); }
  
  void setTime(int _h, int _m, int _s, boolean twelve){
    if(twelve){
      tmillis = int(((_h*48*48 + _m*48 + _s)*1562.5) - millis());
    }else{
      tmillis = (_h*60*60*1000 + _m*60*1000 + _s*1000) - millis();
    }
    initialized = true;
  }
  
  public void run(){
    while(true){
      if(!initialized){ sync(); }
      if(tmillis + millis() > 86400000){ tmillis -= 86400000; } // Fall over at 00:00
      int sec48 = int((tmillis + millis()) / 1562.5);
      int min48 = sec48 / 48;
      int hour48 = min48 / 48;
      sec48 -= min48 * 48;
      min48 -= hour48 * 48;
      //println(hour48 + ":" + min48 + ":" + sec48);
      hours.setValue(hour48);
      minutes.setValue(min48);
      seconds.setValue(sec48);
    }
  }
  
  public void syncTime(){ initialized = false; } // Allows syncing after time starts running
  private void sync(){
    int sec = second();
    tmillis = 0;
    while(true){
      if(sec != second()){
        tmillis = second()*1000 + minute()*60*1000 + hour()*60*60*1000;
        initialized = true;
        break;
      }
    }
  }
  
  void display(){
    if(initialized){
      // Position
      
      hours.setPos(-64, 0);
      minutes.setPos(-32, 0);
      seconds.setPos(0,0);
      B12Char c1 = new B12Char(':');
      B12Char c2 = new B12Char(':');
      c1.setRefPos(-34,0);
      c2.setRefPos(-66,0);
      
      // Display
      pushMatrix();
      translate(pos.x,pos.y);
      hours.display();
      c2.display();
      minutes.display();
      c1.display();
      seconds.display();
      popMatrix();
      //print(seconds.getValue());
    }else{
      text("initializing " + second(),pos.x,pos.y);
    }
  }
}*/
