// LiveMethodRelay is simply a MethodRelay with tags and that can be "killed" so it will be removed from the MouseListener array
class LiveMethodRelay extends MethodRelay {
  private boolean live;
  private char tag;

  LiveMethodRelay(Object obj, String name, char _tag, Class... args) {
    super(obj, name, args);
    tag = _tag;
    live = true;
  }
  LiveMethodRelay(Object obj, String name, Class... args) {
    super(obj, name, args);
    tag = '\0';
    live = true;
  }

  char getTag() {return tag;}
  void setTag(char t) {tag = t;}
  
  boolean live() {return live;}
  void kill() {live = false;}
}
