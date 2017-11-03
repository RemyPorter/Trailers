import java.util.UUID;


boolean running = true;
Sequence s = null;

void setup() {
  size(640,640,P3D);
  //fullScreen(P3D);
  stroke(255,255,255,255/3);
  fill(255);
  background(0);
  clear();
  s = buildSequence();
}


void draw() {
  clear();
  if (running) {
    s.build();
  }
  PGraphics frame = buildFrame(width, height);
  image(frame, 0, 0);
}

PGraphics buildFrame(float width, float height) {
  PGraphics frame = render(s, width, height);
  return frame;
}

void saveImage() {
  PGraphics highres = buildFrame(width*4,height*4);
  highres = backdrop(highres);
  String fname = UUID.randomUUID().toString() + ".tif";
  highres.save("images/" + fname);
}

void keyPressed() {
  switch (key) {
    case ' ': running = !running;
              break;
    case 's': saveImage();
              break;
  }
}