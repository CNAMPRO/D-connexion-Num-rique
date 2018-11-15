import ddf.minim.analysis.*;
import ddf.minim.*;
// https://github.com/samuellapointe/ProcessingCubes/blob/master/cubes.pde
class Musique {

  Minim minim;
  AudioPlayer jingle;
  FFT fft;
  PFont f;
  boolean start = true;
  //ArrayList<Bulle> mesBulles;
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
  int x = 0;
  ParticleSystem p1;
  ParticleSystem p2;
  ParticleSystem p3;
  ParticleSystem p4;
  ParticleSystem p5;
  ParticleSystem p6;

  float specLow = 0.03; // 3%
  float specMid = 0.125;  // 12.5%
  float specHi = 0.20;   // 20%
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

  Musique(AudioPlayer j) {
    p1 = new ParticleSystem(new PVector(width/4, (3*height)/4));
    p2 = new ParticleSystem(new PVector((2*width)/4, (3*height)/4));
    p3 = new ParticleSystem(new PVector((3*width)/4, (3*height)/4));
    p4 = new ParticleSystem(new PVector((width)/3, (2*height)/4));
    p5 = new ParticleSystem(new PVector((2*width)/3, (2*height)/4));
    p6 = new ParticleSystem(new PVector((width)/2, (height)/4));

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

    if (fftmaxhi < scoreHi) {
      fftmaxhi = scoreHi;
    }
    if (fftmaxlow < scoreLow) {
      fftmaxlow = scoreLow;
    }
    if (fftmaxmid < scoreMid) {
      fftmaxmid = scoreMid;
    }

    float val = map(scoreLow, 0, fftmaxlow, 0, 12); // hauteur basse
    float valdir = map(scoreHi, 0, fftmaxhi, -7, 0); // direction basse
    float valMid = map(scoreMid, 0, fftmaxmid, 0, 10);// hauteur mid

    if(frameCount%2 == 0)p1.addParticle(random(valdir, valdir*0.7), random(-val, -val*0.5));//random(-5, 5) = départ de la particule axe x random(-2, 0) Vistesse de la particule (hauteur)
    if(frameCount%2 == 0)p2.addParticle(random(-2, 2), random(-val, -val*0.5));
    if(frameCount%2 == 0)p3.addParticle(random(-valdir, -valdir*0.7), random(-val, -val*0.5));
    if(frameCount%2 == 0)p4.addParticle(random(valdir*0.2, valdir*0.4), random(-valMid, -valMid*0.5));
    if(frameCount%2 == 0)p5.addParticle(random(-valdir*0.2, -valdir*0.4), random(-valMid, -valMid*0.5));
    if(frameCount%2 == 0)p6.addParticle(random(-1, 1), random(-1*scoreHi*reduc, 0));

    p1.run();
    p2.run();
    p3.run();
    p4.run();
    p5.run();
    p6.run();
  }
}
