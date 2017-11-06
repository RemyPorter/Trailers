import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;
void setupFx() {
  fx = new PostFX(this);
}

PGraphics applyFx(PGraphics g) {
  return applyFx(fx, g);
}

PGraphics applyFx(PostFX fx, PGraphics g) {
  PGraphics f = createGraphics(g.width, g.height, P3D);
  fx.setResolution(g.width, g.height);
  buildFx(fx.render(g)).compose(f);
  return f;
}
