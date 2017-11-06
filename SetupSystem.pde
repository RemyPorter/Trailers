
Sequence buildSequence() {
  PVector center = v(width/2,height/2);
  return new SequenceBuilder()
  .path(10,
    center,
    v(width/4,height/2),
    center,
    v(3*width/4,height/2)
  )
  .rotator(0,0,PI/120)
  .rotator(10,0,PI/512)
  .pen(200,0, color( 59,170,196,100))
  .pen(203,0, color(224, 63,154,100))
  .sequence();
}

PostFXBuilder buildFx(PostFXBuilder fx) {
  return fx
    .bloom(0.9, 20, 0.25)
    .rgbSplit(25);
}