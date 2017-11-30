import java.awt.Rectangle;
import java.util.Collection;

PVector v(float x, float y) {
  return new PVector(x, y);
}

class SequenceBuilder {
  Sequence s;
  int currentColor;
  Palette p;
  public SequenceBuilder(int numSteps, Palette p) {
    s = new Sequence(numSteps);
    currentColor = color(255,255,255,255);
    this.p = p;
  }
  public SequenceBuilder() {
    this(Integer.MAX_VALUE, new Palette());
  }
  public SequenceBuilder(int numSteps) {
    this(numSteps, new Palette());
  }
  public SequenceBuilder(Palette p) {
    this(Integer.MAX_VALUE, p);
  }

  Sequence sequence() {
    return s;
  }

  void add(Transform t) {
    s.add(t);
  }

  SequenceBuilder anchor(float x, float y) {
    return anchor(new PVector(x,y));
  }

  SequenceBuilder anchor(PVector disp) {
    add(new Anchor(disp));
    return this;
  }

  SequenceBuilder col(int col) {
    currentColor = col;
    return this;
  }
  SequenceBuilder col(int r, int g, int b, int a) {
    currentColor = color(r,g,b,a);
    return this;
  }

  SequenceBuilder col(String name) {
    currentColor = p.fetch(name);
    return this;
  }

  SequenceBuilder pen() {
    return pen(0,0,currentColor);
  }

  SequenceBuilder pen(PVector pos, int col) {
    add(new Pen(pos, col));
    return this;
  }

  SequenceBuilder pen(float x, float y) {
    return pen(new PVector(x, y), currentColor);
  }

  SequenceBuilder pen(float x, float y, int col) {
    return pen(new PVector(x,y), col);
  }

  SequenceBuilder pen(float x, float y, String name) {
    return pen(x,y,p.fetch(name));
  }

  SequenceBuilder pens(PVector pos, PVector step, int n) {
    add(new Pen(pos, color(255,255,255,100)));
    for (int i = 1; i < n; i++) {
      pos = PVector.add(pos, step);
      add(new Pen(pos, color(255,255,255,100)));
    }
    return this;
  }

  SequenceBuilder pens(PVector pos, PVector step) {
    Collection<Integer> colors = p.values();
    if (colors.size() < 0) return pens(pos, step, 3);
    PVector root = pos;
    for (int c : colors) {
      pen(root, c);
      root = PVector.add(root, step);
    }
    return this;
  }

  SequenceBuilder translator(PVector disp, PVector vel, Rectangle bounds) {
    add(new Translator(disp, vel, bounds));
    return this;
  }

  SequenceBuilder translator(float x, float y, float dx, float dy, float bx, float by, int w, int h) {
    return translator(
      new PVector(x,y),
      new PVector(dx, dy),
      new Rectangle((int)bx, (int)by, (int)w, (int)h)
    );
  }

  SequenceBuilder rotator() {
    return rotator(0,0,0.125);
  }

  SequenceBuilder rotator(float x, float y, float speed) {
    return this.rotator(new PVector(x,y), speed);
  }

  SequenceBuilder rotator(PVector p, float speed) {
    add(new Rotator(p, speed));
    return this;
  }

  SequenceBuilder path(float speed, PVector... points) {
    Path pa = new Path(speed);
    for (PVector p : points) {
      pa.point(p);
    }
    add(pa);
    return this;
  }

  SequenceBuilder ellipse(float x, float y, float major, float minor, float speed) {
    add(new Ellipse(v(x,y),major,minor,speed));
    return this;
  }

  SequenceBuilder sin(float x, float y, float scaleX, float scaleY, float speed) {
    add(new SinTranslator(new PVector(x,y), scaleX, scaleY, speed));
    return this;
  }

  private Transform getLast() {
    return s.steps.get(s.steps.size() - 1);
  }

  private void setLast(Transform t) {
    s.steps.set(s.steps.size() - 1, t);
  }

  SequenceBuilder ratchet(int frames) {
    Transform last = getLast();
    setLast(new Ratchet(last, frames));
    return this;
  }

  SequenceBuilder ramp(float step, float max) {
    Transform last = getLast();
    setLast(new Ramp(last, step, max));
    return this;
  }

  SequenceBuilder osc(String patt, String... mappings) {
    Transform last = getLast();
    setLast(new OscWrapper(patt, last, mappings));
    return this;
  }

  SequenceBuilder oscColor(String patt) {
    Transform last = getLast();
    setLast(new ColorWrapper(patt, last));
    return this;
  }

  SequenceBuilder oscColor(String patt, Palette p) {
    Transform last = getLast();
    setLast(new PaletteWrapper(patt, p, last));
    return this;
  }

  SequenceBuilder oscMomentum(String patt, float friction) {
    Transform last = getLast();
    setLast(new PositionWrapper(patt, friction, last));
    return this;
  }

  SequenceBuilder oscSpeed(String patt) {
    Transform last = getLast();
    setLast(new SpeedWrapper(patt, last));
    return this;
  }
}