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
  String sceneSelected;
  ParticleSystem ps;

  float specLow = 0.03; // 3%
  float specMid = 0.125;  // 12.5%
  float specHi = 0.20;   // 20%
  float scoreLow = 0;
  float scoreMid = 0;
  float scoreHi = 0;
  float oldScoreLow = scoreLow;
  float oldScoreMid = scoreMid;
  float oldScoreHi = scoreHi;
  float scoreDecreaseRate = 25;
  
  //KEVIN
  ArrayList<Gouttes> gouttes  = new ArrayList<Gouttes>();
  int frames = 0;

  Musique(AudioPlayer j, String s) {
    ps = new ParticleSystem(new PVector(width/2, height-50));
    jingle = j;
    fft = new FFT(jingle.bufferSize(), jingle.sampleRate());
    myBuffer = new float[jingle.bufferSize()];
    fft.logAverages( 22, 3);
    jingle.play(0);
    myColor =  new Color();
    myColorEllipse =  new Color();
    myColorTest =  new Color();
    sceneSelected = s;
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
      oldScoreLow = scoreLow;
      oldScoreMid = scoreMid;
      oldScoreHi = scoreHi;
      scoreLow = 0;
      scoreMid = 0;
      scoreHi = 0;
      for (int i = 0; i < fft.specSize()*specLow; i++)
        scoreLow += fft.getBand(i);
      for (int i = (int)(fft.specSize()*specLow); i < fft.specSize()*specMid; i++)
        scoreMid += fft.getBand(i);
      for (int i = (int)(fft.specSize()*specMid); i < fft.specSize()*specHi; i++)
        scoreHi += fft.getBand(i);
      if (oldScoreLow > scoreLow) 
        scoreLow = oldScoreLow - scoreDecreaseRate;
      if (oldScoreMid > scoreMid) 
        scoreMid = oldScoreMid - scoreDecreaseRate;
      if (oldScoreHi > scoreHi) 
        scoreHi = oldScoreHi - scoreDecreaseRate;

      float scoreGlobal = 0.66*scoreLow + 0.8*scoreMid + 1*scoreHi;
      float test = map(scoreGlobal, 50, 200, -1, 1);
      println("Low"+scoreLow);
      println("Mid"+scoreMid);
      println("Hi"+scoreHi);
      ps.addParticle(test);
      ps.run();
      break;
      
      case "scene kevin": 
      oldScoreLow = scoreLow;
      oldScoreMid = scoreMid;
      oldScoreHi = scoreHi;
      scoreLow = 0;
      scoreMid = 0;
      scoreHi = 0;
      for (int i = 0; i < fft.specSize()*specLow; i++)
        scoreLow += fft.getBand(i);
      for (int i = (int)(fft.specSize()*specLow); i < fft.specSize()*specMid; i++)
        scoreMid += fft.getBand(i);
      for (int i = (int)(fft.specSize()*specMid); i < fft.specSize()*specHi; i++)
        scoreHi += fft.getBand(i);
      if (oldScoreLow > scoreLow) 
        scoreLow = oldScoreLow - scoreDecreaseRate;
      if (oldScoreMid > scoreMid) 
        scoreMid = oldScoreMid - scoreDecreaseRate;
      if (oldScoreHi > scoreHi) 
        scoreHi = oldScoreHi - scoreDecreaseRate;
        
      
      float y = map(scoreLow+scoreMid+scoreHi,0,2800,0,height);
      scoreLow = map(scoreLow,0,1300,0,1);
      scoreMid = map(scoreMid,0,1000,0,1);
      scoreHi = map(scoreHi,0,500,0,1);
      
      
      float scoreTemp = (scoreLow>scoreMid)?scoreLow:scoreMid;
      scoreTemp = (scoreTemp>scoreHi)?scoreTemp:scoreHi;
      
      int type = 0;
      
      type = (scoreTemp == scoreLow)?1:type;
      type = (scoreTemp == scoreMid)?2:type;
      type = (scoreTemp == scoreHi)?3:type;
      
      float x = 0;
      if(type==1)
        x = map(scoreLow,0,1,0,width/3);
      if(type==2)
        x = map(scoreMid,0,1,width/3,2*width/3);
      if(type==3)
        x = map(scoreHi,0,1,2*width/3,width);
        
      
      frames++;
      if(scoreLow != 0 && scoreMid != 0 && scoreHi != 0)
      {
        frames = 0;
        gouttes.add(new Gouttes(x,y,100,60));
      }
      for(int cpt = 0; cpt<gouttes.size();cpt++)
      {
        Gouttes gt = gouttes.get(cpt);
        gt.update();
        if(gt.finished())
        {
          gouttes.remove(cpt);
        }
      }
      println("size " + gouttes.size());
        
      println("type " + type);
      println("Low"+scoreLow);
      println("Mid"+scoreMid);
      println("Hi"+scoreHi);
      break;
    }
  }
}