import java.awt.Rectangle;

PVector v(float x, float y) {
  return new PVector(x, y);
}

class SequenceBuilder {
  Sequence s = new Sequence();
  Sequence sequence() {
    return s;
  }
  SequenceBuilder pen() {
    return pen(new PVector(0,0));
  }

  SequenceBuilder anchor(float x, float y) {
    return anchor(new PVector(x,y));
  }

  SequenceBuilder anchor(PVector disp) {
    s.add(new Anchor(disp));
    return this;
  }

  SequenceBuilder pen(float x, float y) {
    return pen(new PVector(x, y));
  }

  SequenceBuilder pen(PVector pos) {
    s.add(new Pen(pos));
    return this;
  }

  SequenceBuilder pens(PVector pos, PVector step, int n) {
    s.add(new Pen(pos));
    for (int i = 1; i < n; i++) {
      pos = PVector.add(pos, step);
      s.add(new Pen(pos));
    }
    return this;
  }

  SequenceBuilder translator(PVector disp, PVector vel, Rectangle bounds) {
    s.add(new Translator(disp, vel, bounds));
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
    s.add(new Rotator(new PVector(x, y), speed));
    return this;
  }

  SequenceBuilder path(float speed, PVector... points) {
    Path pa = new Path(speed);
    for (PVector p : points) {
      pa.point(p);
    }
    s.add(pa);
    return this;
  }
}