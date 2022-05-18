class Button{
  private LiveMethodRelay listener;
  private MouseHandler mh;
  
  private PVector pos; // Position to render from
  private PVector dim; // Second coordinate for CORNERS or len/wid for CORNER and CENTER
  private float radius; // Optional corner radius
  private int mode; // Stores rect draw mode for button
  private color col; // Stores static color
  private color highlight; // Stores mouseover color
  private String text;
  private float textSize;
  private color textColor;
  private int renderPriority; // 0: default, render text size within button size  1: render button around text
  
  private MethodRelay function; // Gets called when button is pressed
  private boolean mouseOver;
  private Object[] data; // Anything that gets passed to MethodRelay function when key pressed. Must be set manually

  Button(MouseHandler _mh){
    mh = _mh;
    
    pos = new PVector(0,0);
    dim = new PVector(20,20);
    radius = 1;
    mode = CORNER;
    col = color(200);
    colorMode(HSB);
    highlight = color(150);
    text = "";
    textSize = dim.y * 0.8;
    textColor = 0;
    renderPriority = 0;
    
    mouseOver = false;
    listener = new LiveMethodRelay(this, "clicked", 'p', Object.class);
    mh.addRelay(listener);
    data = null;
  }
  
  // GETTERS //
  float[] getRect(){ float[] out = {pos.x, pos.y, dim.x, dim.y}; return out; }
  float getRadius(){return radius;}
  color getColor(){return col;}
  color getHighlight(){return highlight;}
  String getText(){return text;}
  color getTextColor(){return textColor;}
  MethodRelay getFunction(){return function;}
  int getMode(){return mode; }
  int getRenderPriority(){return renderPriority;}
  
  // SETTERS //
  Button setPos(PVector _pos){pos = _pos.copy(); return this;}
  Button setPos(PVector _pos, PVector _dim){pos = _pos.copy(); dim = _dim.copy(); return this; }
  Button setDim(PVector _dim){dim = _dim.copy(); return this;}
  Button setRect(PVector _pos, PVector _dim){pos = _pos; dim = _dim; return this;}
  Button setRadius(float rad){radius = rad; return this;}
  Button setColor(color c){col = c; return this;}
  Button setColor(color c, color h){col = c; highlight = h; return this;}
  Button autoHighlight(){ colorMode(RGB,255); highlight = color(int(red(col) * .85), int(green(col) * .85), int(blue(col) * .85)); return this; }
  Button setHighlight(color h){ highlight = h; return this; }
  Button setText(String t){text = t; return this;}
  Button setTextSize(float s){textSize = s; return this;} // TODO make robust
  Button setTextColor(color c){textColor = c; return this;}
  Button setRenderPriority(int p){if(p < 0 || p > 1) throw new IllegalArgumentException(); renderPriority = p; return this;}
  
  Button setFunction(MethodRelay _function){function = _function; return this;}
  Button setData(Object... _data){ data = _data; return this;} // Data to pass for button presses. Ugh, note that the array already exists because it's passed as such, no need to create a new one. Stupid bug
  Button setMode(int m){ if(m == CORNER || m == CORNERS || m == CENTER || m == RADIUS){mode = m;return this;} /*Otherwise*/ return this;}
  
  // DISPLAY //
  void display(){
    mouseOver(mh.sMouseX(),mh.sMouseY());
    noStroke();
    rectMode(mode);
    fill(mouseOver ? highlight : col);
    rect(pos.x,pos.y,dim.x,dim.y,radius);
    
    fill(textColor);
    textSize(textSize);
    if(renderPriority == 0){
      while(textWidth(text) > dim.x * 0.95){ // WARNING! NOT ROBUST make this a function at some point to allow other rectModes to render properly
        textSize = textSize - 1;
        textSize(textSize);
      }
    }
    //textSize(dim.y * 0.8);
    textAlign(CENTER,BOTTOM);
    text(text,pos.x + dim.x/2,pos.y + dim.y);
  }
  
  
  // MOUSE FUNCTIONS //
  void clicked(Object _mp){ // mp[0] is smouseX and m[1] is smouseY
    float[] mp = (float[])_mp;
    if(mouseOver && mouseButton == LEFT){
      //println("clicked" + this);
      function.execute(data);
      mouseOver = false; // Very important. Without this a button retains its mouseOver status forever if it stops being displayed
    }
  }
  
  // DETECT IF MOUSE IS OVER BUTTON //
  // Must account for rect render mode
  void mouseOver(float x, float y){ // CORNER
    switch(mode){
      case 0:
        mouseOver = !(x < pos.x || x > pos.x + dim.x || y < pos.y || y > dim.y + pos.y); break;
      case 1:
        mouseOver = !(x < (pos.x > dim.x ? dim.x : pos.x) || 
                      x > (pos.x > dim.x ? pos.x : dim.x) || 
                      y < (pos.y > dim.y ? dim.y : pos.y) || 
                      y > (pos.y > dim.y ? pos.y : dim.y)); break;
      case 2:
        mouseOver = !(x < pos.x - dim.x || 
                      x > pos.x + dim.x || 
                      y < pos.x - dim.y || 
                      y > pos.x + dim.y); break;
      case 3:
        mouseOver = !(x < pos.x - dim.x/2 || 
                      x > pos.x + dim.x/2 || 
                      y < pos.x - dim.y/2 || 
                      y > pos.y + dim.y/2); break;
    }
  }
  
  // GARBAGE COLLECTION //
  // kill the mouse listener so it will get removed from the mouse event cascade
  @Override
  protected void finalize(){ 
    //println("finalized");
    listener.kill();
  }
}
