class Gouttes {
  float posX;
  float posY;
  float taille;
  int time;
  int i = 10;
  float r,g,b;
  float opacity = 0;
  Gouttes (float posX, float posY, float taille, int time) {  
    this.posX = posX;
    this.posY = posY;
    this.taille = taille;
    this.time = time;
    r = map(posX,0,width,0,255);
    g = map(posY,0,width,0,255);
    b = map(posX+posY,0,width+height,0,255);
  } 

  void update() {  
   
    if(i<taille)
    {
      i++;
      opacity = map(i,0,taille,0,255);
      fill(255-r,g,b, int(255-opacity));
      stroke(255-r,g,b, int(255-opacity));
      ellipse(posX, posY, i, i);
    }
    time--;
  }

  boolean finished() {
    return (time > 0)?false:true;
  }
} 