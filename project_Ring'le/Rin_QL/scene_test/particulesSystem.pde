
class ParticleSystem {
  ArrayList<Particules> particles;
  PVector origin;
  int type;
  
  ParticleSystem(PVector position) {
    origin = position.copy();
    particles = new ArrayList<Particules>();
  }

  void addParticle() {
    particles.add(new Particules(int(random(0,3)),int(random(10,20)),int(random(-5,10))));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particules p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}
