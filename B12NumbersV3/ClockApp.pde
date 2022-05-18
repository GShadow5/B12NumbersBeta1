class ClockApp{
  PVector pos;
  MouseHandler mh;
  Button[] buttons;
  Button modeButton;
  Button setTimeButton;
  int mode;
  boolean setTime;
  Time48 time;
  TimeDisplay td;
  
  ClockApp(MouseHandler _mh, Time48 _time){
    pos = new PVector(0,0);
    mh = _mh;
    time = _time;
    td = new TimeDisplay(time);
    mode = 0;
    initialize();
  }
  
  PVector getPos(){return pos;}
  
  ClockApp setPos(PVector _pos){pos = _pos.copy(); return this;}
  ClockApp setPos(float x, float y){pos = new PVector(x,y); initialize(); return this;}
  ClockApp setMode(int _mode){
    if(_mode == -1){setTime = true; return this;}
    mode = _mode; 
    initialize();
    return this;
  }
  
  void initialize(){
    buttons = new Button[0];
    td.setPos(43,-4);
    
    if(mode == 0){
      setTimeButton = new Button(mh).setText("Set Time").setPos(new PVector(pos.x+21,pos.y)).setDim(new PVector(42,13)).setFunction(new MethodRelay(this, "setMode", int.class)).setData(-1).setColor(220,150);
      
      // Create numpad buttons
      for(int i = 0; i < 12; i++){
        /* Button position must contain it's absolute position relative to sketch 0,0 for mouseOver to work. 
           This means we cannot translate and traw buttons, we mumst factor the parents position into the
           absolute position of the button */
        // x = pos.x + (width + gap) * (i%cols)
        // y = pos.y + (height + gap) * b2rows - (height + gap) * row
        PVector bPos = new PVector(pos.x + 22 * int(i%4),pos.y + 22 * 2 - 22 * floor(i/4));
        buttons = (Button[])append(buttons, new B12Button(mh ,new B12Digit(i)).setPos(bPos).setDim(new PVector(20,20)).setFunction(new MethodRelay(this, "addChar", B12Digit.class)).setColor(220,150));
      }
      // Create other buttons
      buttons = (Button[])append(buttons, new Button(mh).setText("Set").setPos(new PVector(pos.x,pos.y + 22*3)).setDim(new PVector(42,20)).setFunction(new MethodRelay(this, "evaluate")).setColor(220,150));
      buttons = (Button[])append(buttons, new Button(mh).setText("Clear").setPos(new PVector(pos.x + 22*2,pos.y + 22*3)).setDim(new PVector(42,20)).setFunction(new MethodRelay(this, "clear")).setColor(220,150));
    }
    else if(mode == 1){
    }
    
  }
  
  
  void display(){
    switch(mode){
      case 0:
        clock(); break;
      case 1:
        stopwatch(); break;
      case 2:
        timer(); break;
      case 3:
        setTime(); break;
    }
  }
  
  private void setTime(){
    for(int i = 0; i < buttons.length; i++){
      buttons[i].display();
    }
    td.display();
  }
  
  private void clock(){
    td.display();
    if(!setTime){
      setTimeButton.display();
      return;
    }
    
    for(int i = 0; i < buttons.length; i++){
      buttons[i].display();
    }
  }
  
  private void timer(){
  }
  
  private void stopwatch(){
    
  }
}
