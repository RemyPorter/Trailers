import java.util.UUID;


boolean running = true;
boolean applyFilters = false;
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
  PGraphics frame = render(s);
  
  image(frame,0,0);
}

void saveImage() {
  PImage highres = render(s, width*4,height*4);
  String fname = UUID.randomUUID().toString() + ".tif";
  highres.save("images/" + fname);
}

void keyPressed() {
  switch (key) {
    case ' ': running = !running;
              break;
    case 'f': applyFilters = !applyFilters;
              break;
    case 's': saveImage();
              break;
  }
}