PVector v;
class Particle {
  PVector position;
  ArrayList <PVector> pposition ;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  int tailletab = 5;
  int index = 0;
  
  Particle(PVector l) {
    pposition = new ArrayList<PVector>(tailletab);
    acceleration = new PVector(0, 0.1);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    position = l.copy();
    for (int i=0; i<tailletab; i++) {
      pposition.add(position.copy());
    }
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    if (frameCount%5 == 0) {
      pposition.set(index, position.copy());
      index = (index + 1)%tailletab;
    }
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 5;
  }
  // Method to display
  void display() {

    stroke(255, lifespan);
    //fill(214,255,255, lifespan);
    noFill();
    //ellipse(position.x, position.y, 8, 8);
    beginShape();
    for (int i = 0; i<tailletab; i++) {
      v = pposition.get((i + index)%tailletab);
      vertex(v.x, v.y);
    }
    endShape();
    /*for (int i = 0; i<(tailletab-1); i++) {
     //v = pposition.get((i + index)%tailletab);
     PVector PV= pposition.get((i+index)%tailletab);
     PVector PPV = pposition.get((i + index +1)%tailletab);
     line(PV.x, PV.y, PPV.x, PPV.y);
     }*/
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
