class Gouttes {
  float posX;
  float posY;
  float taille;
  float tailleCircle;
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
    g = map(taille,0,width,0,255);
    b = map(posX+posY,0,width+height,0,255);
  } 

  void update() {
    if(i<taille*0.5)
    {
      tailleCircle++;
      i+=2;
      opacity = map(i,0,taille,0,128);
      fill(255-r,g,b, int(255-opacity*2));
      stroke(255-r,g,b, int(255-opacity));
      ellipse(posX, posY, i, i);
      fill(255-r,g,b, 255);
      stroke(255-r,g,b, 255);
      ellipse(posX, posY, tailleCircle, tailleCircle);
    }
    else if(i<taille)
    {
      i+=2;
      opacity = map(i,0,taille,0,128);
      fill(255-r,g,b, int(255-opacity*2));
      stroke(255-r,g,b, int(255-opacity));
      ellipse(posX, posY, i, i);
    }
    else if(i<taille*1.5)
    {
      i++;
      opacity = map(i,0,taille*2,128,255);
      noFill();
      stroke(255-r,g,b, int(255-opacity));
      ellipse(posX, posY, i, i);
    }
    time--;
  }

  boolean finished() {
    return (time > 0)?false:true;
  }
}
