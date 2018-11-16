class Particle {
  PVector position;
  ArrayList <PVector> pposition ;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  int tailletab = 10;
  int index = 0;

  Particle() {
    pposition = new ArrayList<PVector>(tailletab);
    acceleration = new PVector(0, 0.1);
    position = new PVector(0, 0);
    for (int i=0; i<tailletab; i++) {
      pposition.add(position.copy());
    }
    lifespan = 0.0;  
  }

  void run(float[] colors) {
    update();
    display(colors);
  }

  void update() {
    if (frameCount%5 == 0) {
      pposition.set(index, position.copy());
      index = (index + 1)%tailletab;
    }
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.0;
  }
  // Method to display
  void display(float[] colors) {

    stroke(colors[0], colors[1], colors[2], lifespan);
    //strokeWeight(4);
    fill(colors[0], colors[1], colors[2], lifespan);
    //noFill();
    ellipse(position.x, position.y, 8, 8);
    //beginShape();
    //for (int i = 0; i<tailletab; i+=1) {
    //  PVector v = pposition.get((i + index)%tailletab);
    //  vertex(v.x, v.y);
    //}
    //endShape();
    //for (int i = 0; i<(tailletab-1); i++) {
    //  //v = pposition.get((i + index)%tailletab);
    //  PVector PV= pposition.get((i+index)%tailletab);
    //  PVector PPV = pposition.get((i + index +1)%tailletab);
    //  line(PV.x, PV.y, PPV.x, PPV.y);
    //}
  }

  void activate(PVector _position, PVector _vitesse, float[] colors) {
    velocity =  _vitesse.copy();
    position = _position.copy();
    lifespan= 255;
    fill(colors[0],colors[1],colors[2],lifespan);
    for (int i=0; i<tailletab; i++) {
      pposition.set(i, position.copy());
    }
  }


  // Is the particle still useful?
  boolean isDead() {
    if (lifespan <= 0.0) {
      return true;
    } 
    PVector verifTaille = pposition.get((index+tailletab)%tailletab);
    if (verifTaille.x<0 || verifTaille.y<0 || verifTaille.y>height ||verifTaille.x>width) {
      return true;
    }
    return false;
  }
}
