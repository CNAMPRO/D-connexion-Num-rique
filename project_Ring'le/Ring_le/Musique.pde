import ddf.minim.analysis.*;
import ddf.minim.*;
// https://github.com/samuellapointe/ProcessingCubes/blob/master/cubes.pde
class Musique {

  Minim minim;
  AudioPlayer jingle;
  FFT fft;
  PFont f;
  boolean start = true;

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
  Color myColorParticle;
  String sceneSelected;
  ParticleSystem ps;

  float specLow = 0.02; // 3%
  float specMid = 0.10;  // 12.5%
  float specHi = 0.30;   // 20%
  float scoreLow = 0;
  float scoreMid = 0;
  float scoreHi = 0;
  float oldScoreLow = scoreLow;
  float oldScoreMid = scoreMid;
  float oldScoreHi = scoreHi;
  float scoreDecreaseRate = 25;
  float scoreLowMax = 0;
  float scoreMidMax = 0;
  float scoreHiMax = 0;
  float scoreLowDisplay = 0;
  float scoreMidDisplay = 0;
  float scoreHiDisplay = 0;
  float scoreGlobalMax=0;
  Orchestre orchestre;

  Musique(AudioPlayer j, String s) {
    ps = new ParticleSystem(new PVector(width/2, height-150));
    jingle = j;
    fft = new FFT(jingle.bufferSize(), jingle.sampleRate());
    myBuffer = new float[jingle.bufferSize()];
    fft.logAverages( 22, 3);
    jingle.play(0);
    myColor =  new Color();
    myColorEllipse =  new Color();
    myColorTest =  new Color();
    myColorParticle =  new Color();
    sceneSelected = s;
    orchestre = new Orchestre();
  }
  void closeSong(){
    jingle.close();
  }
  void update() {

    fft.forward(jingle.mix);

    switch(sceneSelected) {
    case "scene ligne": 
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
      break;
    case "scene rond": 
      for (int i = 0; i < 29; i++) {

        float amplitude = fft.getAvg(i);

        if (amplitude<audioThresh) {
          circles[i] = amplitude*(height)*0.4;
        } else {
          circles[i] = max(0, min(height, circles[i]-0.01));
        }
        float[] colors = myColorTest.update(.2);
        stroke(colors[0], colors[1], colors[2], amplitude*255);
        strokeWeight(map(amplitude, 0, 1, STROKE_MIN, STROKE_MAX));
        fill(colors[0], colors[1], colors[2], 150);
        ellipse(height/2+60, width/2-40, circles[i], circles[i]);
      }
      break;
    case "scene fft": 
      for (int i = 0; i < fft.specSize(); i++)
      {
        float[] colors = myColorEllipse.getColors();
        if (i%2 == 0)
          colors = myColorEllipse.update(.1);
        fill(colors[0], colors[1], colors[2], 100);
        ellipse(20+(i*10), height-150, 7, fft.getBand(i) * 5);
      }
      break;
    case "scene test":
      background(0);
      float[] colors = myColorParticle.update(.01);
      scoreLow = 0;
      scoreMid = 0;
      scoreHi = 0;
      for (int i = 0; i < fft.specSize()*specLow; i++)
        scoreLow += fft.getBand(i);
      for (int i = (int)(fft.specSize()*specLow); i < fft.specSize()*specMid; i++)
        scoreMid += fft.getBand(i);
      for (int i = (int)(fft.specSize()*specMid); i < fft.specSize()*specHi; i++)
        scoreHi += fft.getBand(i);

      float scoreGlobal = 0.66*scoreLow + 0.8*scoreMid + 1*scoreHi;

      scoreLowMax = (scoreLow > scoreLowMax)?scoreLow:scoreLowMax;
      scoreMidMax = (scoreMid > scoreMidMax)?scoreMid:scoreMidMax;
      scoreHiMax = (scoreHi > scoreHiMax)?scoreHi:scoreHiMax;
      scoreGlobalMax = (scoreGlobal > scoreGlobalMax)?scoreGlobal:scoreGlobalMax;

      scoreLowDisplay = map(scoreLow, 0, scoreLowMax, -10, -3.05);
      scoreMidDisplay = map(scoreMid, scoreMidMax/4, scoreMidMax, -3.10, 3.90);
      scoreHiDisplay = map(scoreHi, 0, scoreHiMax, 3, 10);
      scoreLow = map(scoreLow, 0, scoreLowMax, 0, 1);
      scoreMid = map(scoreMid, 0, scoreMidMax, 0, 1);
      scoreHi =  map(scoreHi, 0, scoreHiMax, 0, 1);

      float result = 0;
      if (scoreLow > scoreMid) {
        if (scoreLow > scoreHi)
          result = scoreLowDisplay;
        else
          result = scoreHiDisplay;
      } else {
        if (scoreMid > scoreHi)
          result = scoreMidDisplay;
        else
          result = scoreHiDisplay;
      }
      if (scoreGlobal > 30){
        if(frameCount%2==0)ps.addParticle(result, colors);
      }
      float volume = map(scoreGlobal,0,scoreGlobalMax,20,80);
      orchestre.update(result,volume);
      ps.run();
      stroke(255);
      fill(255);
      ellipse(width/2, height-150, 16, 16);
      break;
    }
  }
}
