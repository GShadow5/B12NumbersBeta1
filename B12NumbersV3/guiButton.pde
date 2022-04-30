class Button{
  ClickHandler ch;
  PVector pos; // Position to render from
  PVector dim; // Second coordinate for CORNERS or len/wid for CORNER and CENTER
  int radius; // Optional corner radius
  int mode;
  color c;
  boolean mouseOver;

  Button(ClickHandler _ch, PVector _pos, PVector _dim, int _radius){
    ch = _ch;
    pos = _pos.copy();
    dim = _dim.copy();
    radius = _radius;
    mode = CORNER;
    c = color(200);
    mouseOver = false;
    ch.addl(new LiveMethodRelay(this, "clicked", float.class, float.class));
  }
  Button(ClickHandler _ch, PVector _pos, PVector _dim){
    this(_ch, _pos, _dim, 0);
  }
  
  void setMode(int m){
    if(m == CORNER || m == CORNERS || m == CENTER || m == RADIUS){
      mode = m;
      return; 
    }
    return;
  }
  
  void display(){
    rectMode(mode);
    new MethodRelay(this,"mouseOver" + str(mode), float.class, float.class).execute(mouseX,mouseY);
    if (mouseOver){
      fill(100);
    }else{fill(c);}
    rect(pos.x,pos.y,dim.x,dim.y,radius);
  }
  
  void clicked(float x, float y){
    if(mouseOver){
      println(x + " " + y + " mouse pos");
    }
  }
  
  
  // DETECT IF MOUSE IS OVER BUTTON //
  // The numbers in the method name correspond to the mode ids because the method gets called with a relay
  void mouseOver0(float x, float y){ // CORNER
    //println("CORNER");
    if(x < pos.x || x > dim.x + pos.x || y < pos.x || y > dim.y + pos.y) 
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
