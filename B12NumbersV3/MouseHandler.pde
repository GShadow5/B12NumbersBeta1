class MouseHandler {
  /*  MouseHandler holds the code that listens for mouse actions and passes those
      calls on to the individual LiveMethodRelay listeners in mrs that have been 
      sent to MouseHandler by buttons and other objects that want to listen for
      mouse actions.
  */
  private MouseData md;
  private LiveMethodRelay[] mrs;

  MouseHandler(MouseData _md) {
    md = _md;
    mrs = new LiveMethodRelay[0];
  }
  
  // PASSTHROUGH FOR MOUSE DATA //
  float sMouseX(){return md.sMouseX();}
  float sMouseY(){return md.sMouseY();}
  float pSMouseX(){return md.pSMouseX();}
  float pSMouseY(){return md.pSMouseY();}
  void frameUpdate(PVector offset, float scale){md.update(offset, scale);} // Updates the position of the mouse so that it is translated and scaled properly

  // This is used by outside objects to stick a listner in the listener array
  void addRelay(LiveMethodRelay r) {
    clean();
    if(r.getTag() == '\0'){ throw new IllegalArgumentException("MouseHandler only accepts tagged LiveMethodRelays"); }
    mrs = (LiveMethodRelay[])append(mrs, r);
  }
  
  // clean() removes any dead method relays
  void clean() {
    if (mrs.length == 0) return;
    for (int i = mrs.length -1; i >= 0; i--) {
      if (!mrs[i].live()) {
        mrs[i] = mrs[mrs.length - 1];
        mrs = (LiveMethodRelay[])shorten(mrs);
      }
    }
  }
  
  // Triggers all method relays marked with the input tag. This is called by the built in mouse function overrides
  void cascade(char tag, float... data) {
    clean();
    for (int i = 0; i < mrs.length; i++) {
      if(mrs[i].getTag() == tag){
        mrs[i].execute(data);
      }
    }
  }
}
