import geomerative.*;

RShape grp;

int first = 0;
float x = 0;
void setup() {
  size(600, 600);
  smooth();

  // VERY IMPORTANT: Allways initialize the library before using it
  RG.init(this);

  grp = RG.loadShape("logo_Ringle.svg");
  grp = RG.centerIn(grp, g);
}

void draw() {
  if (x<600) {
    translate(width/2, height/2);
    background(#2D4D83);

    float t = map(x, 0, width, 0, 1);
    RShape[] splittedGroups = grp.splitPaths(t);

    RG.shape(splittedGroups[first]);
    x=x+3;
  }
}
