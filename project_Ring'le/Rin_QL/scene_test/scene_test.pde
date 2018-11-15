ParticleSystem ps;

ParticleSystem ps2;
PImage leaf1,leaf2,leaf3,paysage;

void setup() {
  size(1600,900);
  leaf1 = loadImage("SycamoreLeaf1.png"); 
  leaf2 = loadImage("SycamoreLeaf6.png");
  leaf3 = loadImage("SycamoreLeaf12.png");
  paysage = loadImage("paysage.png");
  ps = new ParticleSystem(new PVector(-200, height/2));
}


void draw() {
  background(paysage);
  // Voir en fonction de la music 
  //if ( frameCount % 5 == 0) {
  if ( random(1) < 0.2 ) {
  
  ps.addParticle();
  }
  ps.run();
}
