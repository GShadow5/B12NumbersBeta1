// B12NumbersV3 //
float scale = 2;
PVector offset;
public static final int DECIMAL = 65;
MouseHandler mh; // Mouse event handler

Calculator calc;
Button b;

void setup(){
  size(400,400);
  offset = new PVector(width/2, height/2);
  mh = new MouseHandler(new MouseData(offset, scale));
  b = new Button(mh, new PVector(20,-20), new PVector(20,20));
  b.setFunction(new MethodRelay(this, "changeMode"));
  
  calc = new Calculator(mh);

}

void draw(){
  background(196);
  mh.frameUpdate(offset, scale);
  translate(offset.x,offset.y);
  scale(scale);
  
  if(calc != null) calc.display();
  b.display();
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

void call(String _call){
  method(_call);
}

void changeMode(){
  if(calc == null){
    calc = new Calculator(mh);
    return;
  }
  calc = null;
  Runtime.getRuntime().gc();
}
