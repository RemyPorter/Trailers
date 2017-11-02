Sequence buildSequence() {
    return new SequenceBuilder()
    .rotator(width/2,height/2,-0.01)
    .rotator(100,0,-0.05)
    .pen(200,0)
    .sequence();
}