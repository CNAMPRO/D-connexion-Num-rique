import ddf.minim.analysis.*;
import ddf.minim.*;



Minim minim;
Musique maMusique;
AudioPlayer jingle;
AudioPlayer jingle2;
Background bg;

void setup()
{
  frameRate(60);
  minim = new Minim(this);
  size(700, 600);
  jingle = minim.loadFile("lake.wav");
  jingle2 = minim.loadFile("lake.wav");
  maMusique = new Musique(jingle, jingle2);
  bg = new Background();
}

void draw()
{
  //println(frameRate
  background(0);
  maMusique.update();
}
