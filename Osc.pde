import netP5.*;
import oscP5.*;

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

class BaseObserver extends BaseWrapper implements OscObserver {
  public BaseObserver(String addr, Transform wrapped) {
    super(wrapped);
    oscHandler.put(addr, this);
  }

  void handleMessage(OscMessage msg) {
    
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