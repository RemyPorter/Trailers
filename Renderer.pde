import java.awt.Rectangle;

interface FilterOp {
  void apply(PImage frame);
}

class Tint implements FilterOp {
  int tnt;
  public Tint(int tint) {
    this.tnt = tint;
  }
  void apply(PImage frame) {
    tint(tnt);
  }
}

class Draw implements FilterOp {
  void apply(PImage frame) {
    image(frame, 0, 0);
  }
}

class MoveDraw implements FilterOp {
  PVector disp;
  public MoveDraw(PVector disp) {
    this.disp = disp;
  }
  void apply(PImage frame) {
    image(frame, disp.x, disp.y);
  }
}

class Slide implements FilterOp {
  PVector disp;
  public Slide(PVector disp) {
    this.disp = disp;
  }
  void apply(PImage frame) {
    translate(disp.x, disp.y);
  }
}

class Jitter implements FilterOp {
  Rectangle bounds;
  float amount;
  PVector pos;
  public Jitter(float amount, int x, int y, int w, int h) {
    this.amount = amount;
    this.bounds = new Rectangle(x,y,w,h);
    this.pos = new PVector(x + w / 2, y + h / 2);
  }
  void apply(PImage frame) {
    PVector jit = PVector.random2D();
    jit.mult(amount);
    PVector next = PVector.add(pos, jit);
    if (bounds.contains(next.x,next.y)) {
      pos = next;
    }
    translate(pos.x, pos.y);
  }
}

class FilterChain {
  ArrayList<FilterOp> ops = new ArrayList<FilterOp>();
  FilterChain add(FilterOp f) {
    ops.add(f);
    return this;
  }

  FilterChain draw() {
    return add(new Draw());
  }

  FilterChain draw(float x, float y) {
    return add(new MoveDraw(new PVector(x, y)));
  }

  FilterChain tint(int clr) {
    return add(new Tint(clr));
  }

  FilterChain jitter(float amount) {
    return add(new Jitter(amount,0,0,3,3));
  }

  FilterChain jitter(float amount, int w, int h) {
    return add(new Jitter(amount,0,0,w,h));
  }

  FilterChain slide(float x, float y) {
    return add(new Slide(new PVector(x,y)));
  }

  void run(PImage frame) {
    for (FilterOp f : ops) {
      f.apply(frame);
    }
  }
}