class LineSegment {
  float x1, y1, x2, y2;
  int col;
  public LineSegment(float x1, float y1, float x2, float y2, int col) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.col = col;
  }
  void draw(PGraphics g) {
    g.stroke(col);
    g.line(x1, y1, x2, y2);
  }
}
class Sequence {
  ArrayList<Transform> steps = new ArrayList<Transform>();
  ArrayList<LineSegment> lines = new ArrayList<LineSegment>();
  void add(LineSegment ls) {
    if (ls != null) lines.add(ls);
  }
  void build() {
    int pops = 0;
    for (Transform s : steps) {
      pushMatrix();
      s.tick();
      s.transform();
      add(s.draw());
      pops++;
    }
    for (int i = 0; i < pops; i++) {
      popMatrix();
    }
  }

  void draw(PGraphics g) {
    for (LineSegment l : lines) {
      l.draw(g);
    }
  }

  void add(Transform t) {
    steps.add(t);
  }
}