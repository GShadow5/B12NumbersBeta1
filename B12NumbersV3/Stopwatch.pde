class Stopwatch{
  /*
      A self contained stopwatch widget
  */
  private PVector pos;
  private MouseHandler mh;
  private STime48 time;
  private TimeDisplay td;
  private Button[] buttons;
  private boolean running;
  private color stopCol;
  
  Stopwatch(MouseHandler _mh){
    pos = new PVector(0,0);
    mh = _mh;
    time = new STime48().setTime(new Time48(0));
    td = new TimeDisplay(new Time48(0));
    buttons = new Button[0];
    running = false;
    initialize();
  }
  
  PVector getPos(){return pos;}
  
  Stopwatch setPos(PVector _pos){pos = _pos.copy(); return this;}
  Stopwatch setPos(float x, float y){pos = new PVector(x,y); return this;}
  
  private void initialize(){
    stopCol = 100;
    td.setPos(pos.x + 13*4 + 2,pos.y-2).setCol(stopCol);
    buttons = (Button[])append(buttons, new Button(mh).setText("Start").setPos(new PVector(pos.x - 14 - 30,pos.y + 2)).setDim(new PVector(28,16)).setFunction(new MethodRelay(this, "startt")).setColor(220,150));
    buttons = (Button[])append(buttons, new Button(mh).setText("Stop").setPos(new PVector(pos.x - 14,pos.y + 2)).setDim(new PVector(28,16)).setFunction(new MethodRelay(this, "stopp")).setColor(220,150));
    buttons = (Button[])append(buttons, new Button(mh).setText("Reset").setPos(new PVector(pos.x + 16,pos.y + 2)).setDim(new PVector(28,16)).setFunction(new MethodRelay(this, "reset")).setColor(220,150));
  }
  
  void display(){
    for(int i = 0; i < buttons.length; i++){
      buttons[i].display();
    }
    td.display();
  }
  
  void startt(){
    if(running) return;
    td.setTime(time.setTime(td.getTime())).setCol(0);
    running = true;
  }
  
  void stopp(){
    if(!running )return;
    td.setTime(new Time48(time)).setCol(stopCol);
    running = false;
  }
  
  void reset(){
    td.setTime(new Time48(0)).setCol(stopCol);
    running = false;
  }
}
