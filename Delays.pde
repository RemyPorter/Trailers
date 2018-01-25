class DelayWrapper extends BaseWrapper {
  String field;
  float value;
  int frames;
  public DelayWrapper(Transform wrapped, int frames, String field, float value) {
    super(wrapped);
    this.frames = frames;
    this.field = field;
    this.value = value;
  }

  public void tick() {
    super.tick();
    if (frameCount == frames) {
      setValue(field, value);
    }
  }

  private void setValue(String field, float value) {
    Transform wrapped = unwrap();
    try {
      Field f = wrapped.getClass().getDeclaredField(field);
      f.setFloat(wrapped, value);
    } catch (Exception ex) {
      println("Unable to fire delay.");
      println(ex.getMessage());
    }
  }
}

class PauseDelay extends BaseWrapper {
  int frames;
  public PauseDelay(Transform wrapped, int frames) {
    super(wrapped);
    this.frames = frames;
  }
  public void tick() {
    super.tick();
    if (frameCount == frames) {
      Transform wrapped = unwrap();
      try {
        Pausable p = (Pausable)wrapped;
        p.toggle();
      } catch (Exception ex) {
        println(ex.getMessage());
      }
    }
  }
}