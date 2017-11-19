class BaseWrapper implements Transform {
  Transform wrapped;
  public Transform getWrapped() {
    return wrapped;
  }
  public BaseWrapper(Transform wrapped) {
    this.wrapped = wrapped;
  }
  void transform() {
    wrapped.transform();
  }
  void tick() {
    wrapped.tick();
  }
  LineSegment draw() {
    return wrapped.draw();
  }
  Transform unwrap() { //we sometimes need a REAL instance of a transform to access its properties
    Transform w = this.wrapped;
    while(w instanceof BaseWrapper) {
      w = ((BaseWrapper)this.wrapped).getWrapped();
    }
    return w;
  }
}

class Ratchet extends BaseWrapper {
  int ratchetBy;
  int ticks = 0;
  public Ratchet(Transform wrapped, int ratchetBy) {
    super(wrapped);
    this.ratchetBy = ratchetBy;
  }

  void tick() {
    ticks++;
    if (ticks >= ratchetBy) {
      for (int i = 0; i < ratchetBy; i++) {
        wrapped.tick();
      }
      ticks = 0;
    }
  }
}

class Ramp extends BaseWrapper {
  float max,step,i;
  public Ramp(Transform wrapped, float step, float max) {
    super(wrapped);
    this.step = step;
    this.max = max;
    this.i = 0;
  }

  void tick() {
    i += step;
    if (i > max) i = 0;
    if (i < 0) i = max;
    for (int j = 0; j < i; j++) {
      wrapped.tick();
    }
  }
}