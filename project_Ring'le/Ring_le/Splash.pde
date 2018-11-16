class Splash { 
  RShape shp;
  RShape polyshp;
  float x = 1100;
  AudioPlayer splash;
  boolean start = true;
  boolean close = false;
  Splash (AudioPlayer splash1, AudioPlayer splash2) {  
    smooth();
    shp = RG.loadShape("logo_Ringle.svg");
    shp = RG.centerIn(shp, g, 100);
    splash1.play(0);
    splash = splash2;
  } 

  void closeSong() {
    splash.close();
    splash1.close();
    close = true;
  }


  void update() {
    if (!close) {
      if (splash1.position() > 4800) {
        if (start) {
          splash1.close();
          splash.play(0);
          start = false;
        }
      }
      if (splash.position() < 3000) {
        float pointSeparation = map(constrain(x, 100, width-100), 800, width-100, 5, 200);

        RG.setPolygonizer(RG.UNIFORMLENGTH);
        RG.setPolygonizerLength(pointSeparation);

        polyshp = RG.polygonize(shp);
        translate(width/2, height/2);
        RG.shape(polyshp);
        x--;
      } else {
        splash.close();
      }
    }
  }

  boolean finished() {
    return (splash.position() > 3000)?true:false;
  }
} 
