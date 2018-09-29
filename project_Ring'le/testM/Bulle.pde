class Bulle { 
  PFont f;
  float posX;
  float posY;
  float taille;
  float tailleCercle;
  int time;
  int i = 0;
  Bulle (float posX, float posY, float taille, int time) {  
    this.posX = posX;
    this.posY = posY;
    this.taille = taille;
    this.time = time;
  } 

  void update() {  
    //int m = millis();
   // println((m/500)%2);
    if (i == 30 || i == 59) time--;
    if (time > 0) {
      fill(180,180,180, 250);
      stroke(180,180,180, 250);
      for (int i = 1; i < 30; i++) {
        fill(0,0,0,10);
        ellipse(posX, posY, taille/i, taille/i);
      }
      ellipse(posX, posY, taille, taille);
    }
    taille = taille + 0.5;
    i = (i == 59)?0:i+1;
  }

  boolean finished() {
    return (time > 0)?false:true;
  }
  
  boolean isHit(float x, float y){
    return (posX - x<50 && posY-y <50)?true:false;
  }
} 
