class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  String type;

  ParticleSystem(PVector position,String type) {
    origin = position.copy();
    particles = new ArrayList<Particle>();
    this.type = type;
  }

  void addParticle(float direction, float[] colors) {
    if(type == "Orchestre" || type == "Intro")
      particles.add(new Particle(origin,direction, colors,type));
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
