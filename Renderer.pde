PGraphics render(Sequence s) {
  return render(s, width,height);
}

PGraphics render(Sequence s, float w, float h) {
  PGraphics g = createGraphics((int)w,(int)h, P3D);
  g.beginDraw();
  g.scale(w/width, h/height);
  g.stroke(255,255,255,255/3);
  g.strokeWeight(3);
  s.draw(g);
  g.endDraw();
  return g;
}

PGraphics backdrop(PGraphics source) {
  return backdrop(source, 0);
}

PGraphics backdrop(PGraphics source, int background) {
  PGraphics dest = createGraphics(source.width, source.height, P3D);
  dest.beginDraw();
  dest.background(background);
  dest.clear();
  dest.image(source, 0, 0);
  dest.endDraw();
  return dest;
}