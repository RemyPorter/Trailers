class Palette extends HashMap<String, Integer> {
  Palette col(String name, int col) {
    put(name, col);
    return this;
  }

  Palette col(String name, int r, int g, int b, int a) {
    return col(name, color(r,g,b,a));
  }

  int fetch(String name) {
    if (containsKey(name)) {
      return get(name);
    } else {
      return 255;
    }
  }
}