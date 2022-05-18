class Clock{
  PVector pos;
  MouseHandler mh;
  Button[] buttons;
  Button setTimeButton;
  boolean setTime;
  int cursorPos;
  STime48 time;
  TimeDisplay td;
  
  Clock(MouseHandler _mh, STime48 _time){
    pos = new PVector(0,0);
    mh = _mh;
    time = _time;
    td = new TimeDisplay(time);
    setTime = false;
    cursorPos = 0;
    initialize();
  }
  
  PVector getPos(){return pos;}
  
  Clock setPos(PVector _pos){pos = _pos.copy(); return this;}
  Clock setPos(float x, float y){pos = new PVector(x,y); initialize(); return this;}
  
  void initialize(){
    buttons = new Button[0];
    td.setPos(pos.x,pos.y);    
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
    buttons = (Button[])append(buttons, new Button(mh).setText("Set").setPos(new PVector(pos.x,pos.y + 22*3)).setDim(new PVector(42,20)).setFunction(new MethodRelay(this, "lockTime")).setColor(220,150));
    buttons = (Button[])append(buttons, new Button(mh).setText("Clear").setPos(new PVector(pos.x + 22*2,pos.y + 22*3)).setDim(new PVector(42,20)).setFunction(new MethodRelay(this, "clearTime")).setColor(220,150));
    
    setTimeButton = new Button(mh).setText("Set Time").setPos(new PVector(pos.x+21,pos.y)).setDim(new PVector(42,13)).setFunction(new MethodRelay(this, "triggerSetTime")).setColor(220,150);
    
  }
  /*
  void addChar(B12Digit digit){
    switch(cursorPos){
    }
    cursorPos
  }*/
  
  void clearTime(){
    td.setTime(new Time48(0));
  }
  
  void lockTime(){
    time.setTime(td.getTime());
    td.setTime(time);
    setTime = false;
  }
  
  void triggerSetTime(){
    clearTime();
    setTime = true;
  }
  
  void display(){
    if(setTime){
      for(int i = 0; i < buttons.length; i++){
        buttons[i].display();
      }
    }else{
      setTimeButton.display();
    }
    td.display();
  }
}
