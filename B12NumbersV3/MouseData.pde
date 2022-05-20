class MouseData{
  /*  MouseData stores properly translated and scaled mouse position for things like buttons
  */
  private PVector offset;
  private float scale;
  private float sMouseX;
  private float sMouseY;
  private float pSMouseX;
  private float pSMouseY;
  
  PVector getOffset(){return offset.copy();}
  float getScale(){return scale;}
  
  MouseData(PVector _offset, float _scale){
    offset = _offset;
    scale = _scale;
    sMouseX = (mouseX - offset.x)/scale; 
    sMouseY = (mouseY - offset.y)/scale;
    pSMouseX = (pmouseX - offset.x)/scale;
    pSMouseY = (pmouseY - offset.y)/scale;
  }
  
  void update(PVector _offset, float _scale){
    offset = _offset;
    scale = _scale;
    sMouseX = (mouseX - offset.x)/scale; 
    sMouseY = (mouseY - offset.y)/scale;
    pSMouseX = (pmouseX - offset.x)/scale;
    pSMouseY = (pmouseY - offset.y)/scale;
  }
  
  float sMouseX(){return sMouseX;}
  float sMouseY(){return sMouseY;}
  float pSMouseX(){return pSMouseX;}
  float pSMouseY(){return pSMouseY;}
}
