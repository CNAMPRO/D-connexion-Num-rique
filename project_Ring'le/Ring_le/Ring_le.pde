import ddf.minim.analysis.*;
import ddf.minim.*;
import geomerative.*;
import controlP5.*;
ControlP5 cp5;



Minim minim;
Musique maMusique;
AudioPlayer jingle, splash1, splash2, menuSong;
Splash splash;
boolean start = false;
boolean musiqueSelect = false;
boolean startScene1 = false;
Color myColor=  new Color();
Color myColor2=  new Color();
float[] colors = new float[3];
float[] colors2 = new float[3];
String sceneSelected = "";
boolean skipIntro = false;
ParticleSystem ps1, ps2;

void setup()
{
  cp5 = new ControlP5(this);
  cp5.setFont(createFont("Arial", 10));
  RG.init(this);
  frameRate(60);
  minim = new Minim(this);
  splash1 = minim.loadFile("splashMusic.mp3");
  splash2 = minim.loadFile("getItem.mp3");
  menuSong = minim.loadFile("menuSong.mp3");
  splash = new Splash(splash1, splash2);
  ps1 = new ParticleSystem(new PVector(-100, height+300),"Intro");
  ps2 = new ParticleSystem(new PVector(width+100, height+300),"Intro");
  fullScreen();
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Mais sélectionne une musique abrutie");
  } else {
    jingle = minim.loadFile(selection.getAbsolutePath());
    maMusique = new Musique(jingle, sceneSelected);
    println("musique selectionné " + selection.getAbsolutePath());
    menuSong.pause();
    start = true;
  }
}

void draw()
{
  colors2 = myColor2.update(.01);
  colors = myColor.update(.01);
  background(colors[0], colors[1], colors[2]);
  if (splash.finished() || skipIntro) {
    fill(0,190);
    ellipse(width/2,height/2,width*2,height*2);
  }
  splash.update();
  if (splash.finished() || skipIntro) {
    if (!musiqueSelect) {
      menuSong.play(0);
      cp5.addButton("Scene leaf").setPosition(width/2-100, height/2+131).setSize(200, 19);
      cp5.addButton("Fontaine").setPosition(width/2-100, height/2+81).setSize(200, 19);
      cp5.addButton("La ligne de la vie").setPosition(width/2-100, height/2+31).setSize(200, 19);
      cp5.addButton("Le fond du bol").setPosition(width/2-100, height/2-19).setSize(200, 19);
      cp5.addButton("Fft").setPosition(width/2-100, height/2-69).setSize(200, 19);
      cp5.addButton("Orchestre").setPosition(width/2-100, height/2-119).setSize(200, 19);
      cp5.addButton("La goutte de trop").setPosition(width/2-100, height/2-169).setSize(200, 19);
      musiqueSelect = true;
    }else if(!start) {
      if (frameCount%2==0)ps1.addParticle(random(-2,2), colors2);
      if (frameCount%2==0)ps2.addParticle(random(-2,2), colors2);
      ps1.run();
      ps2.run();
    }
    if (start)
      maMusique.update();
  }
}
public void controlEvent(ControlEvent theEvent) {
  java.util.List<controlP5.Button> list = cp5.getAll(Button.class);
  for (Button b : list) {
    b.hide();
  }
  sceneSelected = theEvent.getController().getName();
  selectInput("Selection de la musique :", "fileSelected");
}

void keyPressed() {
  if (key == 'q') {
    if (start == true) {
      maMusique.closeSong();
      start = false;
      menuSong.play(0);
      println(menuSong);
      java.util.List<controlP5.Button> list = cp5.getAll(Button.class);
      for (Button b : list) {
        b.show();
      }
    }
  }
  if (key == 'a') {
    if (!splash.finished()) {
      splash.closeSong();
      skipIntro = true;
      float[] colorsSet = {85.400925, 243.56332, 164.59225};
      myColor.setColors(colorsSet);
    }
  }
}
