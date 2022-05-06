class Button{ // TODO make most of the attributes private
  MouseHandler mh;
  PVector pos; // Position to render from
  PVector dim; // Second coordinate for CORNERS or len/wid for CORNER and CENTER
  float radius; // Optional corner radius
  int mode; // Stores rect draw mode for button
  color col; // Stores static color
  color highlight; // Stores mouseover color
  MethodRelay function; // Gets called when button is pressed
  boolean mouseOver;
  Object[] data; // Anything that gets passed to MethodRelay function when key pressed. Must be set manually

  Button(MouseHandler _mh, PVector _pos, PVector _dim, float _radius){
    mh = _mh;
    pos = _pos.copy();
    dim = _dim.copy();
    radius = _radius;
    mode = CORNER;
    col = color(200);
    highlight = color(100);
    mouseOver = false;
    mh.addRelay(new LiveMethodRelay(this, "clicked", 'c', Object.class));
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
  MethodRelay getFunction(){return function;}
  int getMode(){return mode; }
  
  // SETTERS //
  void setRect(PVector _pos, PVector _dim){pos = _pos; dim = _dim; }
  void setRadius(float rad){radius = rad;}
  void setColor(color c){col = c; }
  void setColor(color c, color h){col = c; highlight = h;}
  void setHighlight(color h){ highlight = h; }
  void setFunction(MethodRelay _function){function = _function;}
  void setData(Object... _data){ data = _data; } // Data to pass for button presses. Ugh, note that the array already exists because it's passed as such, no need to create a new one. Stupid bug
  
  void setMode(int m){
    if(m == CORNER || m == CORNERS || m == CENTER || m == RADIUS){
      mode = m;
      return; 
    }
    return;
  }
  
  // DISPLAY //
  void display(){
    noStroke();
    rectMode(mode);
    new MethodRelay(this, "mouseOver" + str(mode), float.class, float.class).execute(mh.sMouseX(),mh.sMouseY());
    fill(mouseOver ? highlight : col);
    rect(pos.x,pos.y,dim.x,dim.y,radius);
  }
  
  
  // MOUSE FUNCTIONS //
  void clicked(Object _mp){ // mp[0] is smouseX and m[1] is smouseY
    float[] mp = (float[])_mp;
    if(mouseOver){
      println(mp[0] + " " + mp[1] + " mouse pos");
      function.execute(data);
    }
  }
  
  // DETECT IF MOUSE IS OVER BUTTON //
  // The numbers in the method name correspond to the mode ids because the method gets called with a relay
  void mouseOver0(float x, float y){ // CORNER
    //println("CORNER");
    if(x < pos.x || x > pos.x + dim.x || y < pos.y || y > dim.y + pos.y) 
    {
      mouseOver = false; 
      return;
    }
    mouseOver = true;
  }
  
  void mouseOver1(float x, float y){ // CORNERS
    //println("CORNERS");
    if(x < (pos.x > dim.x ? dim.x : pos.x) || 
       x > (pos.x > dim.x ? pos.x : dim.x) || 
       y < (pos.y > dim.y ? dim.y : pos.y) || 
       y > (pos.y > dim.y ? pos.y : dim.y))
    {
      mouseOver = false;
      return;
    }
       
    mouseOver = true;
  }
  
  void mouseOver2(float x, float y){ // RADIUS
    //println("RADIUS");
    if(x < pos.x - dim.x || 
       x > pos.x + dim.x || 
       y < pos.x - dim.y || 
       y > pos.x + dim.y) 
    {
      mouseOver = false;
      return;
    }
    mouseOver = true;
  }
  
  void mouseOver3(float x, float y){ // CENTER
    //println("CENTER");
    if(x < pos.x - dim.x/2 || 
       x > pos.x + dim.x/2 || 
       y < pos.x - dim.y/2 || 
       y > pos.y + dim.y/2)
    {
      mouseOver = false;
      return;
    }
    mouseOver = true;
  }
}
