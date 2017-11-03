Sequence buildSequence() {
    return new SequenceBuilder()
    .rotator(width/2,height/2,-0.01)
    .rotator(100,0,-0.05)
    .pen(200,0, color(59,170,196,100))
    .translator(-3,0,0.79,0,-3,0,3,0)
    .pen(200,0, color(255,163, 71,100))
    .sequence();
}