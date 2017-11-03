import java.awt.Rectangle;

interface Transform {
  void transform();
  LineSegment draw();
}

class Pen implements Transform {
  PVector offset;
  PVector lastPos;
  int col;
  public Pen(PVector offset, int col) {
    this.offset = offset;
    this.col = col;
  }
  public void transform() {
    //translate(offset.x, offset.y);
  }
  public LineSegment draw() {
    PVector p = new PVector(modelX(offset.x, offset.y, 0), modelY(offset.x, offset.y, 0));
    if (lastPos == null) {
      lastPos = p;
    }
    LineSegment res = new LineSegment(
      lastPos.x, lastPos.y,
      p.x, p.y, col);
    lastPos = p;
    return res;
  }
}

class Anchor implements Transform {
  PVector disp;
  public Anchor(PVector disp) {
    this.disp = disp;
  }
  public LineSegment draw() {
    return null;
  }
  public void transform() {
    translate(disp.x, disp.y);
  }
}

class Translator implements Transform {
  PVector disp;
  PVector vel;
  Rectangle bounds;
  public Translator(PVector disp, PVector vel, Rectangle bounds) {
    this.disp = disp;
    this.vel = vel;
    this.bounds = bounds;
  }
  public Translator(PVector velocity) {
    this(new PVector(0,0), velocity, new Rectangle(0,0,640,640));
  }
  
  public void transform() {
    disp.add(vel);
    if (bounds.width + bounds.x < disp.x || bounds.x > disp.x) {
      vel.x *= -1;
    } else if (bounds.height + bounds.y < disp.y || bounds.y > disp.y) {
      vel.y *= -1;
    }
    translate(disp.x, disp.y);
  }
  public LineSegment draw() {
    //rect(bounds.x, bounds.y, bounds.w, bounds.h);
    return null;
  }
}

class Rotator implements Transform {
  float defl = 0;
  float speed;
  PVector center;
  public Rotator(float speed) {
    this(new PVector(0,0), speed);
  }
  public Rotator(PVector center, float speed) {
    this.center = center;
    this.speed = speed;
  }
  public LineSegment draw() {
    return null;
  }
  public void transform() {
    translate(center.x, center.y);
    defl += speed;
    rotate(defl);
  }
}

class Path implements Transform{
  RingBuffer<PVector> points = new RingBuffer<PVector>();
  float speed;
  float lerp = 0;
  PVector origin;
  PVector lastPoint;
  PVector target;
  int count = 0;
  public Path(float speed) {
    this.speed = speed;
  }
  public Path point(PVector p) {
    points.add(p);
    return this;
  }
  public Path point(float x, float y) {
    PVector p = new PVector(x,y);
    return point(p);
  }
  public LineSegment draw() {
    return null;
  }
  public void transform() {
    if (points.size() < 1) return;
    if (lastPoint == null) {
      lastPoint = points.moveNext();
      origin = lastPoint;
    }
    if (target == null) {
      target = points.moveNext();
    }
    if (PVector.dist(lastPoint, target) < speed) {
      //we've arrived
      lastPoint = target;
      origin = target;
      target = points.moveNext();
      count = 0;
    } else {
      float d = PVector.dist(origin, target);
      float step = speed / d * count;
      lastPoint = PVector.lerp(origin, target, step);
      count++;
    }
    translate(lastPoint.x, lastPoint.y);
  }
}

class RingBuffer<T> {
  ArrayList<T> content = new ArrayList<T>();
  int idx = -1;
  public void add(T i) {
    content.add(i);
  }
  public T moveNext() {
    idx++;
    idx %= content.size();
    return content.get(idx);
  }

  public int size() {
    return content.size();
  }
  public T peekLast() {
    int last = idx - 1;
    if (last < 0) last = content.size() - 1;
    return content.get(last);
  }
}