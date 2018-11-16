class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float [] colors = new float[3];
  PVector test;
  Particle(PVector l, float direction, float[] colorsX) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(direction, random(-5, -2));
    position = l.copy();
    test = l.copy();
    lifespan = random(20.0,60.0);
    colors[0] = colorsX[0];
    colors[1] = colorsX[1];
    colors[2] = colorsX[2];
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
    float background = map(lifespan,0,20,0,255);
    stroke(colors[0], colors[1], colors[2], background);
    fill(colors[0], colors[1], colors[2], background);
    strokeWeight(4);
    line(position.x, position.y, test.x, test.y);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
