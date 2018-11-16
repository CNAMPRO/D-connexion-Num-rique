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

  void addParticle(float x, float y, float[] colors) {
    Particle p = particles.get(index);
    index = (index + 1)%maxparticles;
    p.activate(origin, new PVector(x, y),colors);
  }

  void run(float [] colors) {
    for (Particle p : particles) {
      if (!p.isDead()) {
        p.run(colors);
      }
    }
  }
}
