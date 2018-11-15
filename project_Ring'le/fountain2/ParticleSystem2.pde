class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  //int index = 0;
  

  ParticleSystem(PVector position) {
    origin = position.copy();
    particles = new ArrayList<Particle>();
  }

  void addParticle(float x,float y) {
    Particle p = new Particle(origin);
    p.velocity.set(x,y);
    particles.add(p);
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}
