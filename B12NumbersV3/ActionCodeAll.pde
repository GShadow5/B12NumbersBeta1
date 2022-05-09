class MouseHandler {
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
  void frameUpdate(PVector offset, float scale){md.update(offset, scale);}//  println(mrs.length + " " + millis());}


  void addRelay(LiveMethodRelay r) {
    clean();
    if(r.getTag() == '\0'){ throw new IllegalArgumentException("MouseHandler only accepts tagged LiveMethodRelays"); }
    mrs = (LiveMethodRelay[])append(mrs, r);
  }

  void clean() {
    if (mrs.length == 0) return;
    for (int i = mrs.length -1; i >= 0; i--) {
      if (!mrs[i].live()) {
        mrs[i] = mrs[mrs.length - 1];
        mrs = (LiveMethodRelay[])shorten(mrs);
      }
    }
  }

  void cascade(char tag, float... data) {
    clean();
    for (int i = 0; i < mrs.length; i++) {
      if(mrs[i].getTag() == tag){
        mrs[i].execute(data);
      }
    }
  }
}

class MouseData{
  private PVector offset;
  private float scale;
  private float sMouseX;
  private float sMouseY;
  private float pSMouseX;
  private float pSMouseY;
  
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



import java.lang.reflect.*;
import java.lang.ref.*;
/**
 A class that encapsulates a named method to be invoked.
 Quark 2015
 see https://forum.processing.org/two/discussion/13093/how-to-call-function-by-string-content.html
 Modified to use weak references
 */
public static class MethodRelay {

  /** The object to handle the draw event */
  private WeakReference reference = null;
  //private Object handlerObject = null;
  /** The method in drawHandlerObject to execute */
  private Method handlerMethod = null;
  /** the name of the method to handle the event */
  private String handlerMethodName;
  /** An array of classes that represent the function
   parameters in order */
  private Class[] parameters = null;

  /**
   Register a method that has parameters.
   parameter obj the object that contains the method to invoke
   parameter name the name of the method
   parameter args a comma separated list of
   */
  MethodRelay(Object obj, String name, Class... args) {
    try {
      handlerMethodName = name;
      parameters = args;
      handlerMethod = obj.getClass().getMethod(handlerMethodName, parameters);
      reference = new WeakReference(obj);
    }
    catch (Exception e) {
      println("Unable to find the function -");
      print(handlerMethodName + "( ");
      if (parameters != null) {
        for (Class c : parameters)
          print(c.getSimpleName() + " ");
        println(")");
      }
    }
  }

  /**
   Register a method that has no parameters.
   parameter obj the object that contains the method to invoke
   parameter name the name of the method
   */
  MethodRelay(Object obj, String name) {
    this(obj, name, (Class[])null);
  }

  /**
   Execute a paramerterless method
   */
  void execute() {
    execute((Object[])null);
  }

  /**
   Execute a method with parameters
   parameter data a comma separated list of values
   to be passed to the method
   */
  void execute(Object... data) {
    if (reference.get() != null) {
      try {
        handlerMethod.invoke(reference.get(), data);
      }
      catch (Exception e) {
        println("Error on invoke");
      }
    }
  }
}
