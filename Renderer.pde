PGraphics render(Sequence s) {
  return render(s, width,height);
}

PGraphics render(Sequence s, float w, float h) {
  PGraphics g = createGraphics((int)w,(int)h, P3D);
  g.beginDraw();
  g.background(0);
  g.clear();
  g.scale(w/width, h/height);
  g.stroke(255,255,255,255/3);
  g.strokeWeight(3);
  s.draw(g);
  g.endDraw();
  return g;
}