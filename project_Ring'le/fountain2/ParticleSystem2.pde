class ParticleSystem {
  PVector origin;
  int index = 0;
  int maxparticles = 1000;
  ArrayList<Particle> particles = new ArrayList<Particle>(maxparticles);

  ParticleSystem(PVector position) {
    origin = position.copy();
    particles = new ArrayList<Particle>(maxparticles);
    for(int i = 0 ; i<maxparticles ; i++){
      particles.add(new Particle());
    }
  }

  void addParticle(float x, float y) {
    Particle p = particles.get(index);
    index = (index + 1)%maxparticles;
    p.activate(origin, new PVector(x, y));
  }

  void run() {
    for (Particle p : particles) {
      if (!p.isDead()) {
        p.run();
      }
    }
  }
}
