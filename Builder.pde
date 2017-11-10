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
    return pen(0,0);
  }

  SequenceBuilder anchor(float x, float y) {
    return anchor(new PVector(x,y));
  }

  SequenceBuilder anchor(PVector disp) {
    s.add(new Anchor(disp));
    return this;
  }

  SequenceBuilder pen(PVector pos, int col) {
    s.add(new Pen(pos, col));
    return this;
  }

  SequenceBuilder pen(float x, float y) {
    return pen(new PVector(x, y), color(255,255,255,100));
  }

  SequenceBuilder pen(float x, float y, int col) {
    return pen(new PVector(x,y), col);
  }

  SequenceBuilder pens(PVector pos, PVector step, int n) {
    s.add(new Pen(pos, color(255,255,255,100)));
    for (int i = 1; i < n; i++) {
      pos = PVector.add(pos, step);
      s.add(new Pen(pos, color(255,255,255,100)));
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
    return this.rotator(new PVector(x,y), speed);
  }

  SequenceBuilder rotator(PVector p, float speed) {
    s.add(new Rotator(p, speed));
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

  SequenceBuilder ellipse(float x, float y, float major, float minor, float speed) {
    s.add(new Ellipse(v(x,y),major,minor,speed));
    return this;
  }

  SequenceBuilder sin(float x, float y, float scaleX, float scaleY, float speed) {
    s.add(new SinTranslator(new PVector(x,y), scaleX, scaleY, speed));
    return this;
  }
}