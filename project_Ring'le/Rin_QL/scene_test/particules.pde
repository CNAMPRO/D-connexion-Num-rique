
class Particules {
  
  PImage leaf;
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float noiseScale ;
  int scale;
  float rotationX;
  float rotationY;
  ArrayList<PVector> ppos; 
  float alpha;
  int tallArray;
  int rgb;
  
  public Particules(int typeFeuille, int scale, int tallArray) {
    this.tallArray= tallArray;
    this.alpha=255;
    this.rgb = #F0F0F0;
    if(this.tallArray < 0) {
     this.tallArray =10; 
    }
    this.ppos =  new ArrayList (this.tallArray);
    if(typeFeuille == 0) {
      leaf = leaf1;
    } else if(typeFeuille == 1) {
      leaf = leaf2;
    } else {
      leaf = leaf3;
    }
    this.scale=scale;
    velocity = new PVector(random(10,20),0);
    position = new PVector(-20,random(0,height));
    for (int i=0; i<this.tallArray;i++) {
      PVector v = position.copy();
      ppos.add(v);
    }
    rotationX = random(0,2*PI);
    lifespan = 255.0;
  }
  
  void run() {
    update();
    display();
  }
  
  void update() {
   for (int i=this.tallArray-1; i>=1;i--) {
     PVector memory = ppos.get(i-1);
     ppos.set(i,memory);
   }
   if(this.tallArray != 0) {
    ppos.set(0,position.copy());
   }
    noiseScale = 0.01;
    // force du vent pouvant être modifié via lamplitude de la music a un instant donné
    float ventX = 12;
    float ventY = 5;
    float nx = noise(position.x*noiseScale,position.y*noiseScale,frameCount*noiseScale);
    float ax = map(nx,0,1,-ventX,ventX);
    float ny = noise(position.x*noiseScale+1000,position.y*noiseScale+120000,frameCount*noiseScale);
    float ay = map(ny,0,1,-ventY,ventY);
    PVector turbulence = new PVector(ax,ay);
    velocity.add(turbulence);
    PVector dirvent = new PVector(1,0);
    velocity.add(dirvent);
    PVector grav = new PVector(0,0.2);
    velocity.add(grav);
    position.add(velocity);
    // rotation feuille 
    float rnx = noise(position.x*noiseScale,position.y*noiseScale,frameCount*noiseScale);
    rotationX += map(rnx,0,1,0.1,0.5);
    lifespan -= 1.0;
  }
  
  void display() {


    
    // dessins ligne 
    for (int i=0; i<this.tallArray-1;i++) {
      alpha = map(i,0,this.tallArray-1,0,255);
      line(ppos.get(i).x,ppos.get(i).y,ppos.get(i+1).x,ppos.get(i+1).y);
      stroke(this.rgb,alpha);
    }

    pushMatrix();
    translate(position.x,position.y);
    rotate(rotationX);
    //image(leaf,-width/scale/2,-height/scale/2,width/scale, height/scale);
    strokeWeight(1);
    fill(0);
    stroke(255);
    myLeaf(20);
    popMatrix();
    } 
    
  
  public boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
  
  public void myLeaf(float s) {
    beginShape();
    vertex(0,-2*s);
    vertex(1*s,-1*s);
    vertex(2*s,-1*s);
    vertex(1*s,0);
    vertex(2*s,1*s);
    vertex(0,1*s);
    vertex(0,3*s);
    vertex(0,1*s);
    vertex(-2*s,1*s);
    vertex(-1*s,0);
    vertex(-2*s,-1*s);
    vertex(-1*s,-1*s);
    //vertex(0,-2);
    endShape(CLOSE);
  }
  
}
