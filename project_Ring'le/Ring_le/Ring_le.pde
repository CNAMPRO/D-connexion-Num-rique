import ddf.minim.analysis.*;
import ddf.minim.*;
import geomerative.*;
import controlP5.*;
ControlP5 cp5;



Minim minim;
Musique maMusique;
AudioPlayer jingle, splash1, splash2;
Splash splash;
boolean start = false;
boolean musiqueSelect = false;
boolean startScene1 = false;
void setup()
{
  cp5 = new ControlP5(this);


  RG.init(this);
  frameRate(60);
  minim = new Minim(this);
  splash1 = minim.loadFile("splashMusic.mp3");
  splash2 = minim.loadFile("getItem.mp3");
  splash = new Splash(splash1, splash2);
  size(700, 600);
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Mais sélectionne une musique abrutie");
  } else {
    jingle = minim.loadFile(selection.getAbsolutePath());
    maMusique = new Musique(jingle);
    println("musique selectionné " + selection.getAbsolutePath());
    start = true;
  }
}

void draw()
{
  background(150);
  splash.update();
  if (splash.finished()) {
    if (!musiqueSelect) {
      cp5.addButton("scene 1")
        .setPosition(width/2-100, height/2-19)
        .setSize(200, 19)
        ;
      musiqueSelect = true;
    }
    if (start)
      maMusique.update();
  }
}
public void controlEvent(ControlEvent theEvent) {
  theEvent.getController().hide();
  selectInput("Selection de la musique :", "fileSelected");
}
