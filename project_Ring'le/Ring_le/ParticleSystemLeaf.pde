
class ParticulesSystemLeaf {
  ArrayList<ParticleLeaf> particles;
  PVector origin;
  int type;
  
  ParticulesSystemLeaf(PVector position) {
    origin = position.copy();
    particles = new ArrayList<ParticleLeaf>();
  }

  void addParticles() {
    particles.add(new ParticleLeaf(int(random(0,3)),int(random(10,20)),int(random(-5,10))));
  }

  void run(float low, float mid, float hight, float ampli) {
    for (int i = particles.size()-1; i >= 0; i--) {
      ParticleLeaf p = particles.get(i);
      p.run(low,mid,hight,ampli);
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}
