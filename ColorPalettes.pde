/*
*** Primary color:

   0: color( 59,170,196,100)
   1: color(143,214,231,100)
   2: color( 94,191,213,100)
   3: color( 28,150,179,100)
   4: color(  4,120,147,100)

*** Secondary color (1):

   0: color(224, 63,154,100)
   1: color(243,147,201,100)
   2: color(233, 99,175,100)
   3: color(215, 28,134,100)
   4: color(191,  0,108,100)

*** Secondary color (2):

   0: color(186,245, 68,100)
   1: color(218,251,152,100)
   2: color(200,248,106,100)
   3: color(172,242, 32,100)
   4: color(148,222,  0,100)

*** Complement color:

   0: color(255,163, 71,100)
   1: color(255,204,154,100)
   2: color(255,181,109,100)
   3: color(255,143, 33,100)
   4: color(238,118,  0,100)
*/
Palette vaporwave;
void buildVaporwave() {
  vaporwave = new Palette()
    .add("main", "p", 59,170,196,100)
    .add("main", "a", 186,245, 68,100)
    .add("main", "b", 186,245, 68,100)
    .add("main", "c", 255,163, 71,100)
    .add("alt", "p", 143,214,231,100)
    .add("alt", "a", 243,147,201,100)
    .add("alt", "b", 218,251,152,100)
    .add("alt", "c", 255,204,154,100)
    .add("alt1", "p",  94,191,213,100)
    .add("alt1", "a", 233, 99,175,100)
    .add("alt1", "b", 200,248,106,100)
    .add("alt1", "c", 255,181,109,100);
}

void buildPalettes() {
  buildVaporwave();
}