import java.util.UUID;


boolean running = true;
Sequence s = null;
boolean record = false;

void setup() {
  size(640,640,P3D);
  //fullScreen(P3D);
  stroke(255,255,255,255/3);
  fill(255);
  buildPalettes();
  setupFx();
  background(0);
  clear();
  s = buildSequence();
}

PGraphics frameWithFx(int width, int height) {
  PGraphics frame = buildFrame(width, height);
  return applyFx(frame);
}

void draw() {
  clear();
  if (running) {
    s.build();
  }
  PGraphics frame = frameWithFx(width, height);
  image(frame, 0, 0);
  if (record) {
    saveFrame("animated/#####.png");
  }
}



void save() {
  saveImage(frameWithFx(width*2,height*2));
}

void keyPressed() {
  switch (key) {
    case ' ': running = !running;
              break;
    case 's': save();
              break;
  }
}
