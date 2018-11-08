import ddf.minim.analysis.*;
import ddf.minim.*;
// https://github.com/samuellapointe/ProcessingCubes/blob/master/cubes.pde
class Musique {

  Minim minim;
  AudioPlayer jingle;
  FFT fft;
  PFont f;
  boolean start = true;
  ArrayList<Bulle> mesBulles;
  float pop = random(30, 100);
  float[] circles = new float[29];
  float gain = 100;
  int tbase = 512;
  float[] myBuffer;
  float DECAY_RATE = 2;
  float spectrumScale = 2;
  float STROKE_MAX = 3;
  float STROKE_MIN = 1;
  float strokeMultiplier = 1;
  float audioThresh = .5;
  Color myColorEllipse;
  Color myColorTest;
  Color myColor;

  Musique(AudioPlayer j) {
    jingle = j;
    fft = new FFT(jingle.bufferSize(), jingle.sampleRate());
    myBuffer = new float[jingle.bufferSize()];
    fft.logAverages( 22, 3);
    jingle.play(0);
    myColor =  new Color();
    myColorEllipse =  new Color();
    myColorTest =  new Color();
  }
  void update() {
    for (int i = 0; i < jingle.bufferSize(); ++i) {
      myBuffer[i] = jingle.left.get(i);
    }
    int offset = 0;
    float maxdx = 0;
    for (int i = 0; i < myBuffer.length/4; ++i)
    {
      float dx = myBuffer[i+1] - myBuffer[i]; 
      if (dx > maxdx) {
        offset = i;
        maxdx = dx;
      }
    }
    int mylen = min(tbase, myBuffer.length-offset);
    
    for (int i = 0; i < mylen -1; i = i + 1)
    {
      float[] colors = myColor.update(.01);
      float x1 = map(i, 0, tbase, 0, width);
      float x2 = map(i+1, 0, tbase, 0, width);
      stroke(colors[0], colors[1], colors[2]);
      line(x1, 100 - myBuffer[i+offset]*gain, x2, 100 - myBuffer[i+1+offset]*gain);
    }
    f = createFont("Arial", 16, true); 
    textFont(f, 12); 
    fill(255);
    text("musique premier plan : "+(int)jingle.position()/1000, 500, 30);
    stroke(255, 255, 255, 50);

    fft.forward(jingle.mix);
    for (int i = 0; i < 29; i++) {

      float amplitude = fft.getAvg(i);

      if (amplitude<audioThresh) {
        circles[i] = amplitude*(height)*0.4;
      } else {
        circles[i] = max(0, min(height, circles[i]-0.01));
      }
      float[] colors = myColorTest.update(.2);
      stroke(colors[0],colors[1],colors[2], amplitude*255);
      strokeWeight(map(amplitude, 0, 1, STROKE_MIN, STROKE_MAX));
      fill(colors[0],colors[1],colors[2], 150);
      ellipse(height/2+60, width/2-40, circles[i], circles[i]);
    }
    println();
    for (int i = 0; i < fft.specSize(); i++)
    {
      float[] colors = myColorEllipse.getColors();
      if(i%2 == 0)
        colors = myColorEllipse.update(.1);
      fill(colors[0],colors[1],colors[2], 100);
      ellipse(20+(i*10), height-150, 7, fft.getBand(i) * 5);
    }
  }
}
