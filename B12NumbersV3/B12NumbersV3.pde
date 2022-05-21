/**
 * Nayan Sawyer  ns9573@bard.edu
 * May 21 2022
 * CMSC 141
 * Final Project: Base 12 Toolkit
 *
 * Comments/Reflections: The calculator uses B12Expression, MathPad, B12Button, and MathDisplay.
 * The clock app uses Clock, Stopwatch, Timer, and TimeDisplay
 *
 * Collaboration Statement: I used the processing docs, method relay code by Quark - see https://forum.processing.org/two/discussion/13093/how-to-call-function-by-string-content.html
 * and the exp4j library see - https://www.objecthunter.net/exp4j/index.html
 */

import net.objecthunter.exp4j.*; // Math expression evaluation library

// B12NumbersV3 //
String dbout = new String("");
float scale = 4;
PVector offset;
public static final int DECIMAL = 65;
MouseHandler mh; // Mouse event handler

int mode; // State variable 

Button modeButton;
ClockApp capp;
Calculator calc;

void setup(){
  // Initialize all the foundation stuff
  size(800,800); //<>//
  offset = new PVector(width/2, height/2);
  scale = 4;
  mh = new MouseHandler(new MouseData(offset, scale));
  offset = new PVector(width/2, height/2);
  
  mode = 0; // Set initial mode
  
  // Create the apps
  modeButton = new Button(mh).setPos(new PVector(-13,-offset.y / scale + 2), new PVector(26,10)).setRadius(2).setColor(#8B687F).autoHighlight().setText("Mode").setFunction(new MethodRelay(this, "changeMode"));
  capp = new ClockApp(mh).setPos(0,-20);
  calc = new Calculator(mh, new B12Expression());
}

void draw(){
  background(196);
  mh.frameUpdate(offset, scale); // Updates scaled and offset mouse position data in mh.md (the MouseData object)
  translate(offset.x,offset.y);
  scale(scale);
  
  modeButton.display();
  
  
  switch(mode){
    case 0: // Mode 0 is the clock app
      capp.display(); break;
    case 1: // Mode 1 is the calculator app
      text("Calculator",-1,-offset.y/scale + 28);
      calc.display(); break;
  }
}

// Mouse Handler code. This is used with buttons to run actions
void mouseClicked(){
  // Every clickable element needs check whether the mouse is over it every frame, and if both clicked and mouseover then do action.
  mh.cascade('c', mh.sMouseX(), mh.sMouseY(), mouseButton);
}
void mouseMoved(){mh.cascade('m', mh.sMouseX(), mh.sMouseY());}
void mousePressed(){mh.cascade('p', mh.sMouseX(), mh.sMouseY(), mouseButton);}
void mouseReleased(){mh.cascade('r', mh.sMouseX(), mh.sMouseY(), mouseButton);}
void mouseWheel(MouseEvent event){mh.cascade('w', mh.sMouseX(), mh.sMouseY(), event.getCount());}
void mouseDragged(){mh.cascade('d', mh.sMouseX(), mh.sMouseY(), mouseButton);}

void changeMode(){ // Changes state variable to switch apps
  mode = (mode + 1) % 2;
}
