void saveImage(PImage g) {
  String fname = UUID.randomUUID().toString() + ".tif";
  g.save("images/" + fname);
}