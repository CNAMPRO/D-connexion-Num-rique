class Ellipse {
  float x;
  float y;
  float taille = 20;
  Ellipse(float x, float y) {
      this.x = x;
      this.y = y;
  }

  void update() {
    if(taille>20) taille = taille-1;
     ellipse(x, y, taille, taille);
  }
  float getX(){
    return x;
  }
  float getY(){
    return y;
  }
  void selected(float volume){
    taille = volume;
  }
}
