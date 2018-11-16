class ParticleSystemFontaine {
  PVector origin;
  int index = 0;
  int maxparticles = 1000;
  ArrayList<ParticleFontaine> particles = new ArrayList<ParticleFontaine>(maxparticles);

  ParticleSystemFontaine(PVector position) {
    origin = position.copy();
    particles = new ArrayList<ParticleFontaine>(maxparticles);
    for(int i = 0 ; i<maxparticles ; i++){
      particles.add(new ParticleFontaine());
    }
  }

  void addParticle(float x, float y, float[] colors) {
    ParticleFontaine p = particles.get(index);
    index = (index + 1)%maxparticles;
    p.activate(origin, new PVector(x, y),colors);
  }

  void run(float [] colors) {
    for (ParticleFontaine p : particles) {
      if (!p.isDead()) {
        p.run(colors);
      }
    }
  }
}
