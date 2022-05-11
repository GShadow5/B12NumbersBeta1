// B12NumbersV3 //
float scale = 2;
PVector offset;
public static final int DECIMAL = 65;
MouseHandler mh; // Mouse event handler

Calculator calc;
Button reset;
Button eval;


void setup(){
  size(400,400);
  offset = new PVector(width/2, height/2);
  mh = new MouseHandler(new MouseData(offset, scale));
  
  calc = new Calculator(mh);
  
  reset = new Button(mh).setPos(new PVector(20,-20), new PVector(40,20)).setRadius(2).setColor(#06BA63).autoHighlight().setText("Reset").setFunction(new MethodRelay(this, "changeMode"));
  eval = new Button(mh).setPos(new PVector(20,-40), new PVector(40,20)).setRadius(2).setColor(#06BA63).autoHighlight().setText("Eval").setFunction(new MethodRelay(calc.ex, "evaluate"));
  
  

}

void draw(){
  background(196);
  mh.frameUpdate(offset, scale);
  stroke(0);
  strokeWeight(1);
  line(width/2,0,width/2,height);
  line(0,height/2,width,height/2);
  translate(offset.x,offset.y);
  scale(scale);
  
  if(calc != null) calc.display();
  reset.display();
  eval.display();
  
  
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
