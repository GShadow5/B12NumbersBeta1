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
  
  private MethodRelay function; // Gets called when button is pressed
  private boolean mouseOver;
  private Object[] data; // Anything that gets passed to MethodRelay function when key pressed. Must be set manually

  Button(MouseHandler _mh, PVector _pos, PVector _dim, float _radius){
    mh = _mh;
    
    pos = _pos.copy();
    dim = _dim.copy();
    radius = _radius;
    mode = CORNER;
    col = color(200);
    colorMode(HSB);
    highlight = color(150);
    text = "";
    
    mouseOver = false;
    listener = new LiveMethodRelay(this, "clicked", 'p', Object.class);
    mh.addRelay(listener);
    data = null;
  }
  Button(MouseHandler _mh, PVector _pos, PVector _dim){
    this(_mh, _pos, _dim, 0);
  }
  
  // GETTERS //
  float[] getRect(){ float[] out = {pos.x, pos.y, dim.x, dim.y}; return out; }
  float getRadius(){return radius;}
  color getColor(){return col;}
  color getHighlight(){return highlight;}
  String getText(){return text;}
  MethodRelay getFunction(){return function;}
  int getMode(){return mode; }
  
  // SETTERS //
  Button setRect(PVector _pos, PVector _dim){pos = _pos; dim = _dim; return this;}
  Button setRadius(float rad){radius = rad; return this;}
  Button setColor(color c){col = c; return this;}
  Button setColor(color c, color h){col = c; highlight = h; return this;}
  Button autoHighlight(){ colorMode(RGB,255); highlight = color(int(red(col) * .85), int(green(col) * .85), int(blue(col) * .85)); return this; }
  Button setHighlight(color h){ highlight = h; return this; }
  Button setText(String t){text = t; return this;}
  
  Button setFunction(MethodRelay _function){function = _function;return this;}
  Button setData(Object... _data){ data = _data; return this;} // Data to pass for button presses. Ugh, note that the array already exists because it's passed as such, no need to create a new one. Stupid bug
  Button setMode(int m){ if(m == CORNER || m == CORNERS || m == CENTER || m == RADIUS){mode = m;return this;} /*Otherwise*/ return this;}
  
  // DISPLAY //
  void display(){
    noStroke();
    rectMode(mode);
    new MethodRelay(this, "mouseOver" + str(mode), float.class, float.class).execute(mh.sMouseX(),mh.sMouseY());
    fill(mouseOver ? highlight : col);
    rect(pos.x,pos.y,dim.x,dim.y,radius);
    fill(0);
    textSize(dim.y * 0.8);
    textAlign(CENTER,BOTTOM);
    text(text,pos.x + dim.x/2,pos.y + dim.y);
  }
  
  
  // MOUSE FUNCTIONS //
  void clicked(Object _mp){ // mp[0] is smouseX and m[1] is smouseY
    float[] mp = (float[])_mp;
    if(mouseOver && mouseButton == LEFT){
      //println(mp[0] + " " + mp[1] + " mouse pos");
      //println(col + " : " + highlight);
      function.execute(data);
    }
  }
  
  // DETECT IF MOUSE IS OVER BUTTON //
  // The numbers in the method name correspond to the mode ids because the method gets called with a relay
  void mouseOver0(float x, float y){ // CORNER
    mouseOver = !(x < pos.x || x > pos.x + dim.x || y < pos.y || y > dim.y + pos.y) ;
  }
  
  void mouseOver1(float x, float y){ // CORNERS
    //println("CORNERS");
    mouseOver = !(x < (pos.x > dim.x ? dim.x : pos.x) || 
                  x > (pos.x > dim.x ? pos.x : dim.x) || 
                  y < (pos.y > dim.y ? dim.y : pos.y) || 
                  y > (pos.y > dim.y ? pos.y : dim.y));
  }
  
  void mouseOver2(float x, float y){ // RADIUS
    //println("RADIUS");
    mouseOver = !(x < pos.x - dim.x || 
                  x > pos.x + dim.x || 
                  y < pos.x - dim.y || 
                  y > pos.x + dim.y);
  }
  
  void mouseOver3(float x, float y){ // CENTER
    //println("CENTER");
    mouseOver = !(x < pos.x - dim.x/2 || 
                  x > pos.x + dim.x/2 || 
                  y < pos.x - dim.y/2 || 
                  y > pos.y + dim.y/2);
  }
  
  // GARBAGE COLLECTION //
  // kill the mouse listener so it will get removed from the mouse event cascade
  @Override
  protected void finalize(){ 
    //println("finalized");
    listener.kill();
  }
}
