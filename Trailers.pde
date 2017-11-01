boolean running = true;
boolean applyFilters = false;
Sequence s = null;
FilterChain f = null;
void setup() {
  size(640,640,P3D);
  //fullScreen(P3D);
  stroke(255,255,255,255/3);
  fill(255);
  background(0);
  clear();
  s = buildSequence();
  f = buildFilters();
}


void draw() {
  clear();
  PGraphics frame = createGraphics(width,height,P3D);
  textureMode(NORMAL);
  frame.beginDraw();
  frame.stroke(255,255,255,255/3);
  frame.strokeWeight(3);
  if (s != null) {
    if (running) {
      s.build();
    }
    s.draw(frame);
  }
  frame.endDraw();
  if (f == null || !applyFilters) {
    tint(255);
    image(frame,0,0);
  } else {
    f.run(frame);
  }
}

void mousePressed() {
  saveFrame("images/trailers###.png");
}

void keyPressed() {
  switch (key) {
    case ' ': running = !running;
              break;
    case 'f': applyFilters = !applyFilters;
              break;
    case 's': mousePressed();
              break;
  }
}