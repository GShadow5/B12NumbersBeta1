class Timer{
  /*
      A self contained timer widget
      Based on Clock, but different enough that it does not inherit it
      
      Technically sets a synced time to zero, and subtracts whatever that 
      synced time currently happens to be from a target Time48 set to the 
      length of the timer and displays that as it gets smaller.
  */
  PVector pos;
  MouseHandler mh;
  Button[] buttons;
  Button setTimeButton;
  boolean setTime;
  int cursorPos;
  STime48 time;
  Time48 target;
  TimeDisplay td;
  boolean running;
  
  Timer(MouseHandler _mh){
    pos = new PVector(0,0);
    mh = _mh;
    time = new STime48().setTime(new Time48(0));;
    target = new Time48(0);
    td = new TimeDisplay(new Time48(0));
    setTime = true;
    running = false;
    cursorPos = 0;
    initialize();
  }
  
  PVector getPos(){return pos;}
  
  Timer setPos(PVector _pos){pos = _pos.copy(); initialize(); return this;}
  Timer setPos(float x, float y){pos = new PVector(x,y); initialize(); return this;}
  
  void initialize(){
    buttons = new Button[0];
    td.setPos(pos.x + 13*4 + 2,pos.y-2);    
    // Create numpad buttons
    for(int i = 0; i < 12; i++){
      /* Button position must contain it's absolute position relative to sketch 0,0 for mouseOver to work. 
         This means we cannot translate and traw buttons, we mumst factor the parents position into the
         absolute position of the button */
      // x = pos.x + (width + gap) * (i%cols)
      // y = pos.y + (height + gap) * b2rows - (height + gap) * row
      PVector bPos = new PVector(pos.x + 22 * int(i%4) - 43,pos.y + 22 * 2 - 22 * floor(i/4) + 2);
      buttons = (Button[])append(buttons, new B12Button(mh ,new B12Digit(i)).setPos(bPos).setDim(new PVector(20,20)).setFunction(new MethodRelay(this, "addChar", B12Digit.class)).setColor(220,150));
    }
    // Create other buttons
    buttons = (Button[])append(buttons, new Button(mh).setText("Start").setPos(new PVector(pos.x - 43,pos.y + 22*3 + 2)).setDim(new PVector(27,20)).setFunction(new MethodRelay(this, "lockTime")).setColor(220,150));
    buttons = (Button[])append(buttons, new Button(mh).setText("Clear").setPos(new PVector(pos.x + 29 - 43,pos.y + 22*3 + 2)).setDim(new PVector(28,20)).setFunction(new MethodRelay(this, "clearTime")).setColor(220,150));
    buttons = (Button[])append(buttons, new Button(mh).setText("Cancel").setPos(new PVector(pos.x + 59 - 43,pos.y + 22*3 + 2)).setDim(new PVector(27,20)).setFunction(new MethodRelay(this, "cancelSetTime")).setColor(220,150));
    
    setTimeButton = new Button(mh).setText("Set Time").setPos(new PVector(pos.x-21,pos.y + 2)).setDim(new PVector(42,13)).setFunction(new MethodRelay(this, "triggerSetTime")).setColor(220,150);
    
  }
  
  void addChar(B12Digit digit){ // Same as Clock
    switch(cursorPos){
      case 0:
        td.setTime(new Time48().setHour(digit.getValue() * 12)); cursorPos += 1; break;
      case 1:
        td.setTime(new Time48(td.getTime().tsec()).setHour(digit.getValue() + td.getTime().hours())); cursorPos += 2; break;
      case 3:
        td.setTime(new Time48(td.getTime().tsec()).setMin(digit.getValue() * 12)); cursorPos += 1; break;
      case 4:
        td.setTime(new Time48(td.getTime().tsec()).setMin(digit.getValue() + td.getTime().mins())); cursorPos += 2; break;
      case 6:
        td.setTime(new Time48(td.getTime().tsec()).setSec(digit.getValue() * 12)); cursorPos += 1; break;
      case 7:
        td.setTime(new Time48(td.getTime().tsec() + digit.getValue())); cursorPos += 1; break;
    }
  }
  
  void clearTime(){
    td.setTime(new Time48(0));
    cursorPos = 0;
  }
  
  void lockTime(){
    target = new Time48(td.getTime());
    time.setTime(new Time48(0));
    td.setTime(new Time48().setTsec(target.tsec() - time.tsec()));
    cursorPos = 0;
    setTime = false;
    running = true;
  }
  
  void triggerSetTime(){
    clearTime();
    setTime = true;
    running = false;
  }
  
  void cancelSetTime(){
    //td.setTime(time);
    cursorPos = 0;
    setTime = false;
    running = true;
  }
  
  void display(){
    if(setTime){
      for(int i = 0; i < buttons.length; i++){
        buttons[i].display();
      }
      stroke(0);
      if(cursorPos < 8)line(pos.x - 13 * (4-cursorPos) + 2, pos.y, pos.x - 13 * (4-cursorPos) + 10, pos.y);
    }else{
      setTimeButton.display();
    }
    if(running == true){ // This counts down when running, but allows displayed time to remain static when setting time
      td.setTime(new Time48().setTsec(target.tsec() - time.tsec()));
    }
    td.display();
    if(td.getTime().tsec() < 0){ // Display timer done message when timer is done. This also covers up whatever displayed time happens to be (weired negative signs atm)
      colorMode(RGB,255);
      fill(255,0,0);
      rectMode(CORNERS);
      rect(-13*5,-20,13*5,0);
      fill(0);
      textSize(16);
      textAlign(CENTER,BOTTOM);
      text("Timer Done!",0,0);
    }
  }
}
