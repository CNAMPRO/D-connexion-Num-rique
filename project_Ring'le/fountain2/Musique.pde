import ddf.minim.analysis.*;
import ddf.minim.*;
// https://github.com/samuellapointe/ProcessingCubes/blob/master/cubes.pde
class Musique {

  Minim minim;
  AudioPlayer jingle;
  FFT fft;
  Color myColorEllipse;
  Color myColorTest;
  Color myColor;
  Color myColorParticle;
  PFont f;
  boolean start = true;
  //ArrayList<Bulle> mesBulles;
  float pop = random(30, 100);
  float[] circles = new float[29];
  float gain = 100;
  int tbase = 512;
  float[] myBuffer;
  float [] tabNote = new float[3];
  float [] tabMax= new float[3];
  float DECAY_RATE = 2;
  float spectrumScale = 2;
  float STROKE_MAX = 3;
  float STROKE_MIN = 1;
  float strokeMultiplier = 1;
  float audioThresh = .5;
  int x = 0;
  ParticleSystem p1;
  ParticleSystem p2;
  ParticleSystem p3;
  ParticleSystem p4;
  ParticleSystem p5;
  ParticleSystem p6;

  float specLow = 0.03; // 3%
  float specMid = 0.125;  // 12.5%
  float specHi = 0.30;   // 30%
  float scoreLow = 0;
  float scoreMid = 0;
  float scoreHi = 0;
  float oldScoreLow = scoreLow;
  float oldScoreMid = scoreMid;
  float oldScoreHi = scoreHi;

  float reduc = 0.1;
  float fftmaxlow = 1;
  float fftmaxhi = 1;
  float fftmaxmid = 1;
  int cpt = 0;
  float globalMax = 0;

  Musique(AudioPlayer j) {
    myColorParticle =  new Color();

    p1 = new ParticleSystem(new PVector(width/4, (3*height)/4));
    p2 = new ParticleSystem(new PVector((2*width)/4, (3*height)/4));
    p3 = new ParticleSystem(new PVector((3*width)/4, (3*height)/4));
    p4 = new ParticleSystem(new PVector((width)/3, (2*height)/4));
    p5 = new ParticleSystem(new PVector((2*width)/3, (2*height)/4));
    p6 = new ParticleSystem(new PVector((width)/2, (1.5*height)/4));

    jingle = j;
    fft = new FFT(jingle.bufferSize(), jingle.sampleRate());
    myBuffer = new float[jingle.bufferSize()];
    fft.logAverages( 22, 3);
    jingle.play(0);
  }
  void update() {
    oldScoreLow = scoreLow;
    oldScoreMid = scoreMid;
    oldScoreHi = scoreHi;
    scoreLow = 0;
    scoreMid = 0;
    scoreHi = 0;

    fft.forward(jingle.mix); //avance dans la musique

    for (int i = 0; i < fft.specSize()*specLow; i++)
      scoreLow += fft.getBand(i);
    for (int i = (int)(fft.specSize()*specLow); i < fft.specSize()*specMid; i++)
      scoreMid += fft.getBand(i);
    for (int i = (int)(fft.specSize()*specMid); i < fft.specSize()*specHi; i++)
      scoreHi += fft.getBand(i);
    for (int i = 0; i < jingle.bufferSize(); ++i) {
      myBuffer[i] = jingle.left.get(i);
    }
    tabNote[0] = scoreLow;
    tabNote[1] = scoreMid;
    tabNote[2] = scoreHi;

    float scoreGlobal = 0.66*scoreLow + 0.8*scoreMid + 1*scoreHi;
    globalMax = (scoreGlobal > globalMax)?scoreGlobal:globalMax;
    if (fftmaxhi < scoreHi) {
      fftmaxhi = scoreHi;
    }
    tabMax[2] = fftmaxhi;
    if (fftmaxlow < scoreLow) {
      fftmaxlow = scoreLow;
    }
    tabMax[0] = fftmaxlow;
    if (fftmaxmid < scoreMid) {
      fftmaxmid = scoreMid;
    }
    tabMax[1] = fftmaxmid;
    
    float[][] colors = myColorParticle.udpdateColorMusic(tabNote, tabMax);
    float val = map(scoreGlobal, 0, globalMax, 0, 12); // hauteur basse
    float vald = map(scoreLow, 0, fftmaxlow, -4, 4); // hauteur basse
    float valHi = map(scoreHi, 0, fftmaxhi, 0, 10);
    float valdir = map(scoreHi, 0, fftmaxhi, -5, 0); // direction basse
    float valMid = map(scoreMid, 0, fftmaxmid, 0, 5);// hauteur mid

    if (scoreGlobal > 30) {
      p1.addParticle(random(valdir, valdir*0.7), random(-val, -val*0.5), colors[0]);//random(-5, 5) = départ de la particule axe x random(-2, 0) Vistesse de la particule (hauteur)
      p2.addParticle(random(-vald*0.5, vald*0.5), random(-val, -val*0.5), colors[0]);
      p3.addParticle(random(-valdir, -valdir*1.4), random(-val, -val*0.5), colors[0]);
      p4.addParticle(random(valdir*0.2, valdir*0.4), random(-valMid, -valMid*0.5), colors[1]);// rang 2 gauche
      p5.addParticle(random(-valdir*0.2, valdir*0.2), random(-valMid, -valMid*0.5), colors[1]);
      if (frameCount%2==0)p6.addParticle(random(valdir*0.2, -valdir*0.2), random(-valHi, -valHi*0.5), colors[2]);
    }

    p1.run(colors[0]);
    p2.run(colors[0]);
    p3.run(colors[0]);
    p4.run(colors[1]);
    p5.run(colors[1]);
    p6.run(colors[2]);
  }
}


// pour modifier la direction et accel + facilement a faire avec papounou
//dir = new PVector();
//dir.rotate(random(-PI/6,PI/6));
//dir.multi(random(0.1,1)
