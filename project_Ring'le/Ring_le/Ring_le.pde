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
float[] colors = new float[3];
String sceneSelected = "";

void setup()
{
  cp5 = new ControlP5(this);
  cp5.setFont(createFont("Arial",10));


  RG.init(this);
  frameRate(60);
  minim = new Minim(this);
  splash1 = minim.loadFile("splashMusic.mp3");
  splash2 = minim.loadFile("getItem.mp3");
  menuSong = minim.loadFile("menuSong.mp3");
  splash = new Splash(splash1, splash2);
  fullScreen();
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Mais sélectionne une musique abrutie");
  } else {
    jingle = minim.loadFile(selection.getAbsolutePath());
    maMusique = new Musique(jingle,sceneSelected);
    println("musique selectionné " + selection.getAbsolutePath());
    menuSong.rewind();
    menuSong.close();
    start = true;
  }
}

void draw()
{
  if (!splash.finished()) {
    colors = myColor.update(.01);
  }
  background(colors[0], colors[1], colors[2]);
  splash.update();
  if (splash.finished()) {
    if (!musiqueSelect) {
      menuSong.play(0);
      cp5.addButton("scene ligne").setPosition(width/2-100, height/2+31).setSize(200, 19);
      cp5.addButton("scene rond").setPosition(width/2-100, height/2-19).setSize(200, 19);
      cp5.addButton("scene fft").setPosition(width/2-100, height/2-69).setSize(200, 19);
      cp5.addButton("scene test").setPosition(width/2-100, height/2-119).setSize(200, 19);
      musiqueSelect = true;
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
