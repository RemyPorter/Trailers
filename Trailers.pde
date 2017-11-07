import java.util.UUID;


boolean running = true;
Sequence s = null;
boolean record = false;
boolean withFx = false;

void setup() {
  //size(640,640,P3D);
  fullScreen(P3D);
  stroke(255,255,255,255/3);
  fill(255);
  setupFx();
  background(0);
  clear();
  s = buildSequence();
}

PGraphics frameWithFx(boolean withFx, int width, int height) {
  PGraphics frame = buildFrame(width, height);
  if (withFx) {
    return applyFx(frame);
  } else {
    return frame;
  }
}

void draw() {
  clear();
  if (running) {
    s.build();
  }
  PGraphics frame = frameWithFx(withFx, width, height);
  image(frame, 0, 0);
  if (record) {
    saveFrame("animated/#####.png");
  }
}



void save() {
  saveImage(frameWithFx(withFx, width*2,height*2));
}

void keyPressed() {
  switch (key) {
    case ' ': running = !running;
              break;
    case 's': save();
              break;
    case 'f': withFx = ! withFx;
  }
}
