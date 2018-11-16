class Color {

  float [] rgb = { 125, 125, 125 };
  float [] center_rgb = { 125, 125, 125 };
  float [] phasor = { PI/2, PI, 3*PI/2 };
  float [] colors = { 125, 125, 125 };
  float [] colorsMid = new float [3];
  float [] colorsHi = new float [3];
  float [] colorsLow = new float [3];
  float [][]tabColor = new float [3][3];

  float [] update(float vitesse) {
    colors[0] = center_rgb[0] + rgb[0] * sin(phasor[0]);
    colors[1] = center_rgb[1] + rgb[1] * sin(phasor[1]);
    colors[2] = center_rgb[2] + rgb[2] * sin(phasor[2]);
    phasorUpdate(vitesse);
    return colors;
  }

  float [][] udpdateColorMusic(float [] tabNote, float [] tabMax) {
    //Grave
    colorsLow[0] = map(tabNote[0], 0, tabMax[0], 31, 78);
    colorsLow[1] = map(tabNote[0], 0, tabMax[0], 57, 144);
    colorsLow[2] = map(tabNote[0], 0, tabMax[0], 94, 236);

    //mid
    colorsMid[0] = map(tabNote[1], 0, tabMax[1], 229, 192);
    colorsMid[1] = map(tabNote[1], 0, tabMax[1], 157, 11);
    colorsMid[2] = map(tabNote[1], 0, tabMax[1], 157, 12);

    //Hi
    colorsHi[0] = map(tabNote[2], 0, tabMax[2], 52, 130);
    colorsHi[1] = map(tabNote[2], 0, tabMax[2], 5, 13);
    colorsHi[2] = map(tabNote[2], 0, tabMax[2], 92, 231);
    
    tabColor[0] = colorsLow;
    tabColor[1] = colorsMid;
    tabColor[2] = colorsHi;
    return tabColor;
  }

  void phasorUpdate(float vitesse) {
    for (int i = 0; i<phasor.length; i++) {
      phasor[i] += vitesse;
    }
  }

  float [] getColors() {
    colors[0] = center_rgb[0] + rgb[0] * sin(phasor[0]);
    colors[1] = center_rgb[1] + rgb[1] * sin(phasor[1]);
    colors[2] = center_rgb[2] + rgb[2] * sin(phasor[2]);
    return colors;
  }
}
