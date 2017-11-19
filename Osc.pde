import netP5.*;
import oscP5.*;
import java.lang.reflect.Field;

interface OscObserver {
  void handleMessage(OscMessage msg);
}

class OscObservable extends HashMap<String, OscObserver> {
  void handleMessage(OscMessage msg) {
    OscObserver o = get(msg.addrPattern());
    if (o != null) o.handleMessage(msg);
  }
}

OscObservable oscHandler = new OscObservable();

OscP5 osc = new OscP5(this,12000);
void oscEvent(OscMessage msg) {
  oscHandler.handleMessage(msg);
}

class OscWrapper extends BaseWrapper implements OscObserver {
  String[] mappings;
  public OscWrapper(String addr, Transform wrapped, String... mappings) {
    super(wrapped);
    oscHandler.put(addr, this);
    this.mappings = mappings;
  }

  void handleMessage(OscMessage msg) {
    Transform wrapped = unwrap();
    try {
      int i = 0;
      for (String name : mappings) {
        Field f = wrapped.getClass().getDeclaredField(name); //<>//
        OscArgument value = msg.get(i);
        if (value != null) {
          f.setFloat(wrapped, value.floatValue());
        } else {
          return;
        }
        i++;
      }
    } catch (Exception ex) {
      println("Check your mappings on your OSC Wrapper", ex.getMessage());
    }
  }
}

class ColorWrapper extends BaseWrapper implements OscObserver {
  public ColorWrapper(String addr, Transform wrapped) {
    super(wrapped);
    oscHandler.put(addr, this);
  }

  void handleMessage(OscMessage msg) {
    Transform wrapped = unwrap();
    if (wrapped instanceof Pen) {
      float r,g,b,a;
      r = msg.get(0).floatValue();
      g = msg.get(1).floatValue();
      b = msg.get(2).floatValue();
      a = msg.get(3).floatValue();
      ((Pen)wrapped).setColor(r,g,b,a);
    }
  }
}

class PaletteWrapper extends ColorWrapper {
  Palette p;
  public PaletteWrapper(String addr, Palette p, Transform wrapped) {
    super(addr, wrapped);
    this.p = p;
  }

  void handleMessage(OscMessage msg) {
    Transform wrapped = unwrap();
    if (wrapped instanceof Pen) {
      String name = msg.get(0).stringValue();
      ((Pen)wrapped).setColor(p.fetch(name));
    }
  }
}

class LoggingHandler implements OscObserver {
  public LoggingHandler() {
    oscHandler.put("/hello/world", this);
  }
  void handleMessage(OscMessage msg) {
    println(msg.addrPattern());
  }
}

OscObserver lh = new LoggingHandler();