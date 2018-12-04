class Ellipse {
  float x;
  float y;
  float taille = 20;
  float decrease;
  Ellipse(float x, float y) {
      this.x = x;
      this.y = y;
      this.decrease = random(0.5,2);
  }

  void update() {
    if(taille>20) taille = taille-this.decrease;
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
