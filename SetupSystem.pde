Sequence buildSequence() {
  return new SequenceBuilder()
    .rotator(width/2,height/2,0.1)
    .rotator(90,0,-0.2)
    .pen(20,0)
    .rotator(20,0,-0.01)
    .pen(60,0)
    .sequence();
}

FilterChain buildFilters() {
  return new FilterChain()
    .jitter(1.02)
    .tint(color(207,119,244))
    .draw()
    .jitter(1.1)
    .tint(color(117,213,233))
    .draw(-0.5,2);
}