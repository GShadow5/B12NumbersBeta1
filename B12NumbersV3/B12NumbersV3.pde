/*
    B12NumbersV3
    Beta version of a clock in base 12.
    by Nayan Sawyer
    started Mar 2022
    version 0.1.4.3 April 30 2022
    
    Characters are a variation of Kaktovik Inupiaq numerals
    reversed and in base 12 instead of 20. I take no credit 
    for the design.
    Includes method relay code be Quark - see https://forum.processing.org/two/discussion/13093/how-to-call-function-by-string-content.html
    for more details.
    
    changelog 0.1.4.0
    - Added MethodRelay code from Quark. Some fixes and 
    changes as well. Condesed some things into fewer files 
    for so the ide is easier to use, but they will be moved 
    back into their own files as version 1.0 approaches. 
    Everything is prep for adding gui elements (MethodRelay 
    included)
    
    changelog 0.1.3 
    - Deprecated B12Char by rolling it's code into B12Digit. 
    Makes for easier to handle arrays, and will hopefully 
    make implementing the math functionality much easier.
    It appears that only Clock may need true refactoring to 
    make the most of this change. B12Int and B12Float seem 
    to be fine with simply swithing out the reference.
*/

float scale = 2;
PVector offset;
float sMouseX;
float sMouseY;
public static final int DECIMAL = 65;
ClickHandler ch; // Mouse event handler

Clock clock; //<>//
B12Digit p;
B12Digit t;
MathPad m;

void setup(){
  size(400,400);
  offset = new PVector(width/2, height/2);
  ch = new ClickHandler();
  
  m = new MathPad(ch,new B12Math());
  
  clock = new Clock(new STime48());
  println("waiting");
  p = new B12Digit('+');
  t = new B12Digit('/');
}

void draw(){
  background(196);
  sMouseX = (mouseX - offset.x)/scale;
  sMouseY = (mouseY - offset.y)/scale;
  translate(offset.x,offset.y);
  scale(scale);
  point(0,0);
  m.display();
  clock.display();
  //p.display();
  t.display();
  //println( + " " + ;
}

void mouseClicked(){
  //clock.setTime(new Time48(16,0,0));
  
  // Every clickable element needs check whether the mouse is over it every frame, and if both clicked and mouseover then do action.
  ch.cascade(sMouseX, sMouseY);
}

void call(String _call){
  method(_call);
}
