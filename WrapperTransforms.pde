class BaseWrapper implements Transform {
  Transform wrapped;
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