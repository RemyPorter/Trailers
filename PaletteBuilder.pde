class Palette {
  HashMap<String, HashMap<String, Integer>> colors = new HashMap<String, HashMap<String, Integer>>();

  Palette add(String group, String shade, int r, int g, int b, int a) {
    if (!colors.containsKey(group)) {
      colors.put(group, new HashMap<String, Integer>());
    }
    colors.get(group).put(shade, color(r,g,b,a));
    return this;
  }

  int get(String group, String shade) {
    return colors.get(group).get(shade);
  }
}