class Color {
  
  float [] rgb = { 125, 125, 125 };
  float [] center_rgb = { 125, 125, 125 };
  float [] phasor = { PI/2, PI, 3*PI/2 };
  float [] colors = { 125, 125, 125 };


  float [] update(float vitesse) {
    colors[0] = center_rgb[0] + rgb[0] * sin(phasor[0]);
    colors[1] = center_rgb[1] + rgb[1] * sin(phasor[1]);
    colors[2] = center_rgb[2] + rgb[2] * sin(phasor[2]);
    phasorUpdate(vitesse);
    return colors;
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
