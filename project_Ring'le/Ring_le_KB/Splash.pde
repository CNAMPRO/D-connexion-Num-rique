class Splash { 
  RShape shp;
  RShape polyshp;
  float x = 380;
  AudioPlayer splash;
  boolean start = true;
  Splash (AudioPlayer splash1, AudioPlayer splash2) {  
    smooth();
    shp = RG.loadShape("logo_Ringle.svg");
    shp = RG.centerIn(shp, g, 100);
    splash1.play(0);
    splash = splash2;
  } 

  void update() {
    if (splash1.position() > 4800) {
      if (start) {
        splash.play(0);
        start = false;
      }
    }
    if (splash.position() < 3000) {
      float pointSeparation = map(constrain(x, 100, width-100), 100, width-100, 5, 200);
      RG.setPolygonizer(RG.UNIFORMLENGTH);
      RG.setPolygonizerLength(pointSeparation);

      polyshp = RG.polygonize(shp);
      translate(width/2, height/2);
      RG.shape(polyshp);
      x--;
    }
  }

  boolean finished() {
    return (splash.position() > 3000)?true:false;
  }
} 
