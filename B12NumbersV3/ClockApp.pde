class ClockApp{
  /*
      A container for positioning, displaying, and switching between a clock, stopwatch, and timer
  */
  private PVector pos;
  private MouseHandler mh;
  private Clock clock;
  private Stopwatch st;
  private Timer timer;
  private int mode;
  private Button cmButton; // change mode button
  
  ClockApp(MouseHandler _mh){
    pos = new PVector(0,0);
    mh = _mh; //<>//
    initialize();
  }
  
  private void initialize(){
    clock = new Clock(mh, new STime48()).setPos(pos);
    st = new Stopwatch(mh).setPos(pos);
    timer = new Timer(mh).setPos(pos);
    mode = 0;
    cmButton = new Button(mh).setPos(new PVector(-21,-mh.md.getOffset().y / scale + 18), new PVector(42,10)).setRadius(2).setColor(220,150).setText("Clock Mode").setFunction(new MethodRelay(this, "changeMode"));
  }
  
  private void resetPositions(){
    clock.setPos(pos);
    st.setPos(pos);
    timer.setPos(pos);
  }
  
  PVector getPos(){return pos;}
  
  ClockApp setPos(PVector _pos){pos = _pos.copy(); resetPositions(); return this;}
  ClockApp setPos(float x, float y){setPos(new PVector(x,y)); return this;}
  
  void display(){
    cmButton.display();
    fill(0);
    textSize(10);
    textAlign(CENTER,BOTTOM);
    switch(mode){
      case 0:
        text("Clock",pos.x -2 ,pos.y-20);
        clock.display(); break;
      case 1:
        text("Stopwatch",pos.x -2 ,pos.y-20);
        st.display(); break;
      case 2:
        text("Timer",pos.x -2 ,pos.y-20);
        timer.display(); break;
    }
  }
  
  void changeMode(){
    mode = (mode + 1) % 3;
  }
}
