import geomerative.*;

RShape shp;

int first = 0;
float x = 0;
void setup(){
  size(600, 600);
  smooth();

  // VERY IMPORTANT: Allways initialize the library before using it
  RG.init(this);
  
  shp = RG.loadShape("logo_Ringle.svg");
  shp = RG.centerIn(shp, g, 100);
}

void draw(){
  if(x<590){
    translate(width/2, height/2);
    background(#2D4D83);
  
    noFill();
    stroke(255, 200);
    float splitPos = map(x, 0, width, 0, 1);
    
    RShape[] splitShapes = RG.split(shp, splitPos);
   
    RG.shape(splitShapes[first]);
    x=x+2;
  }
}
