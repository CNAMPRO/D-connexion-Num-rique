import geomerative.*;

RShape shp;
RShape polyshp;
float x = 600;

void setup(){
  size(600, 600);
  smooth();
  RG.init(this);

  shp = RG.loadShape("logo_Ringle.svg");
  shp = RG.centerIn(shp, g, 100);
}

void draw(){
  background(255);

  float pointSeparation = map(constrain(x, 100, width-100), 100, width-100, 5, 200);
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(pointSeparation);

  polyshp = RG.polygonize(shp);
  translate(width/2, height/2);
  RG.shape(polyshp);
  x--;
}
