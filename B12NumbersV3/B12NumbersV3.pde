import net.objecthunter.exp4j.*;

// B12NumbersV3 //
String dbout = new String("");
float scale = 4;
PVector offset;
public static final int DECIMAL = 65;
MouseHandler mh; // Mouse event handler

B12Expression ex;
Calculator calc;

//ClockApp ca;
Clock clock;
Timer timer;
Stopwatch st;

Button mode;
Button changeTime;
STime48 time;



void setup(){
  size(800,800); //<>//
  offset = new PVector(width/2, height/2);
  time = new STime48();
  mh = new MouseHandler(new MouseData(offset, scale));
  ex = new B12Expression();
  
  //ca = new ClockApp(mh, time).setPos(-43,0);
  clock = new Clock(mh, time);//.setPos(40,20);
  timer = new Timer(mh);
  st = new Stopwatch(mh);
  calc = new Calculator(mh, ex);
  
  mode = new Button(mh).setPos(new PVector(-20,-100), new PVector(40,20)).setRadius(2).setColor(#8B687F).autoHighlight().setText("Mode").setFunction(new MethodRelay(this, "changeMode"));
}

void draw(){
  background(196);
  textAlign(LEFT,TOP);
  textSize(30);
  text(dbout,0,0); 
  mh.frameUpdate(offset, scale);
  stroke(0);
  strokeWeight(1);
  crossMark();
  translate(offset.x,offset.y);
  scale(scale);
  
  //if(calc != null) calc.display();
  //if(clock != null) clock.display();
  //if(changeTime != null) changeTime.display();
  //mode.display();
  
  //clock.display();
  //st.display();
  timer.display();
  //point(-15,0);
  
}

void mouseClicked(){
  // Every clickable element needs check whether the mouse is over it every frame, and if both clicked and mouseover then do action.
  mh.cascade('c', mh.sMouseX(), mh.sMouseY(), mouseButton);
}
void mouseMoved(){mh.cascade('m', mh.sMouseX(), mh.sMouseY());}
void mousePressed(){mh.cascade('p', mh.sMouseX(), mh.sMouseY(), mouseButton);}
void mouseReleased(){mh.cascade('r', mh.sMouseX(), mh.sMouseY(), mouseButton);}
void mouseWheel(MouseEvent event){mh.cascade('w', mh.sMouseX(), mh.sMouseY(), event.getCount());}
void mouseDragged(){mh.cascade('d', mh.sMouseX(), mh.sMouseY(), mouseButton);}

void changeMode(){
  if(calc == null){
    //clock = null;
    changeTime = null;
    calc = new Calculator(mh, ex);
    return;
  }
  calc = null;
  //clock = new Clock(time).setPos(new PVector(30,0));
  //changeTime = new Button(mh).setPos(new PVector(-40,-60), new PVector(80,20)).setRadius(2).setColor(#B096A7).autoHighlight().setText("Change Time").setFunction(new MethodRelay(clock, "setTime", Time48.class));
  changeTime.setData(new Time48(12,0,0));
  Runtime.getRuntime().gc();
}

void reset(){
  calc.ex.clear();
}

void crossMark(){
  line(offset.x,0,offset.x,height);
  line(0,offset.y,width,offset.y);
}
