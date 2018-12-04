import ddf.minim.analysis.*;
import ddf.minim.*;
// https://github.com/samuellapointe/ProcessingCubes/blob/master/cubes.pde
class Musique {

  Minim minim;
  AudioPlayer jingle;
  FFT fft;
  PFont f;
  boolean start = true;

  int tailleChef = 16;
  float [] tabNote = new float[3];
  float [] tabMax= new float[3];
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
  ColorFontaine myColorFontaine;
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
  float reduc = 0.1;
  float fftmaxlow = 1;
  float fftmaxhi = 1;
  float fftmaxmid = 1;
  float globalMax = 0;
  Orchestre orchestre;
  ArrayList<Gouttes> gouttes  = new ArrayList<Gouttes>();
  ParticleSystemFontaine p1;
  ParticleSystemFontaine p2;
  ParticleSystemFontaine p3;
  ParticleSystemFontaine p4;
  ParticleSystemFontaine p5;
  ParticleSystemFontaine p6;
  ParticulesSystemLeaf ps2;




  Musique(AudioPlayer j, String s) {
    ps = new ParticleSystem(new PVector(width/2, height-150), "Orchestre");
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
    myColorFontaine =  new ColorFontaine();
    ps2 = new ParticulesSystemLeaf(new PVector(-50, height/2));

    p1 = new ParticleSystemFontaine(new PVector(width/4, (3*height)/4));
    p2 = new ParticleSystemFontaine(new PVector((2*width)/4, (3*height)/4));
    p3 = new ParticleSystemFontaine(new PVector((3*width)/4, (3*height)/4));
    p4 = new ParticleSystemFontaine(new PVector((width)/3, (2*height)/4));
    p5 = new ParticleSystemFontaine(new PVector((2*width)/3, (2*height)/4));
    p6 = new ParticleSystemFontaine(new PVector((width)/2, (1.5*height)/4));
  }
  void closeSong() {
    jingle.close();
  }
  void update() {

    fft.forward(jingle.mix);

    switch(sceneSelected) {
    case "La ligne de la vie": 
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
    case "Le fond du bol": 
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
    case "Fft": 
      for (int i = 0; i < fft.specSize(); i++)
      {
        float[] colors = myColorEllipse.getColors();
        if (i%2 == 0)
          colors = myColorEllipse.update(.1);
        fill(colors[0], colors[1], colors[2], 100);
        ellipse(20+(i*10), height-150, 7, fft.getBand(i) * 5);
      }
      break;
    case "Orchestre":
      float[] colors = myColorParticle.update(.01);
      background(colors[0], colors[1], colors[2]);
      fill(0, 230);
      ellipse(width/2, height/2, width*2, height*2);
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
      float volume = map(scoreGlobal, 0, scoreGlobalMax, 20, 80);
      float v = map(scoreGlobal, 0, scoreGlobalMax, 20, 60);
      if (scoreGlobal > 30) {
        if (frameCount%2==0)ps.addParticle(result, colors,v);
      }
      
      stroke(colors[0], colors[1], colors[2]);
      fill(colors[0], colors[1], colors[2]);
      orchestre.update(result, volume);
      ps.run();
      stroke(255);
      fill(255);
      ellipse(width/2, height-150, 20, 20);
      break;
    case "La goutte de trop": 

      background(30, 30, 30);
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

      scoreLowMax = (scoreLowMax>scoreLow)?scoreLowMax:scoreLow;
      scoreMidMax = (scoreMidMax>scoreMid)?scoreMidMax:scoreMid;
      scoreHiMax = (scoreHiMax>scoreHi)?scoreHiMax:scoreHi;

      float y = map(scoreLow+scoreMid+scoreHi, 0, 2000, 0, height);
      float sizeGoutte = map(y, 0, height, 5, 150);
      y = height - y;

      scoreLow = map(scoreLow, 0, scoreLowMax*0.7, 0, 1);
      scoreMid = map(scoreMid, 0, scoreMidMax*0.7, 0, 1);
      scoreHi = map(scoreHi, 0, scoreHiMax*0.7, 0, 1);


      float scoreTemp = (scoreLow>scoreMid)?scoreLow:scoreMid;
      scoreTemp = (scoreTemp>scoreHi)?scoreTemp:scoreHi;

      int type = 0;

      type = (scoreTemp == scoreLow)?1:type;
      type = (scoreTemp == scoreMid)?2:type;
      type = (scoreTemp == scoreHi)?3:type;

      float x = 0;
      if (type==1)
        x = random(0, width/3);
      if (type==2)
        x = random(width/3, 2*width/3);
      if (type==3)
        x = random(width/3*2, width);

      if (scoreLow != 0 && scoreMid != 0 && scoreHi != 0)
      {
        gouttes.add(new Gouttes(x, y, int(sizeGoutte), 60));
      }
      for (int cpt = 0; cpt<gouttes.size(); cpt++)
      {
        Gouttes gt = gouttes.get(cpt);
        gt.update();
        if (gt.finished())
        {
          gouttes.remove(cpt);
        }
      }
      break;
    case "Fontaine": 
      background(0);
      specLow = 0.03; // 3%
      specMid = 0.125;  // 12.5%
      specHi = 0.30;   // 30%
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

      float scoreGlobalFontaine = 0.66*scoreLow + 0.8*scoreMid + 1*scoreHi;
      globalMax = (scoreGlobalFontaine > globalMax)?scoreGlobalFontaine:globalMax;
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

      float[][] colorsFontaine = myColorFontaine.udpdateColorMusic(tabNote, tabMax);
      float val = map(scoreGlobalFontaine, 0, globalMax, 0, 12); // hauteur basse
      float vald = map(scoreLow, 0, fftmaxlow, -4, 4); // hauteur basse
      float valHi = map(scoreHi, 0, fftmaxhi, 0, 10);
      float valdir = map(scoreHi, 0, fftmaxhi, -5, 0); // direction basse
      float valMid = map(scoreMid, 0, fftmaxmid, 0, 5);// hauteur mid

      if (scoreGlobalFontaine > 30) {
        p1.addParticle(random(valdir, valdir*0.7), random(-val, -val*0.5), colorsFontaine[0]);//random(-5, 5) = départ de la particule axe x random(-2, 0) Vistesse de la particule (hauteur)
        p2.addParticle(random(-vald*0.5, vald*0.5), random(-val, -val*0.5), colorsFontaine[0]);
        p3.addParticle(random(-valdir, -valdir*1.4), random(-val, -val*0.5), colorsFontaine[0]);
        p4.addParticle(random(valdir*0.2, valdir*0.4), random(-valMid, -valMid*0.5), colorsFontaine[1]);// rang 2 gauche
        p5.addParticle(random(-valdir*0.2, valdir*0.2), random(-valMid, -valMid*0.5), colorsFontaine[1]);
        if (frameCount%2==0)p6.addParticle(random(valdir*0.2, -valdir*0.2), random(-valHi, -valHi*0.5), colorsFontaine[2]);
      }

      p1.run(colorsFontaine[0]);
      p2.run(colorsFontaine[0]);
      p3.run(colorsFontaine[0]);
      p4.run(colorsFontaine[1]);
      p5.run(colorsFontaine[1]);
      p6.run(colorsFontaine[2]);
      break;
    case "Scene leaf":
      background(0);
      scoreLow = 0;
      scoreMid = 0;
      scoreHi = 0;
      for (int i = 0; i < fft.specSize()*specLow; i++)
        scoreLow += fft.getBand(i);
      for (int i = (int)(fft.specSize()*specLow); i < fft.specSize()*specMid; i++)
        scoreMid += fft.getBand(i);
      for (int i = (int)(fft.specSize()*specMid); i < fft.specSize()*specHi; i++)
        scoreHi += fft.getBand(i);

      float Ampli = 0.66*scoreLow + 0.8*scoreMid + 1*scoreHi;

      scoreLowMax = (scoreLow > scoreLowMax)?scoreLow:scoreLowMax;
      scoreMidMax = (scoreMid > scoreMidMax)?scoreMid:scoreMidMax;
      scoreHiMax = (scoreHi > scoreHiMax)?scoreHi:scoreHiMax;
      scoreGlobalMax = (Ampli > scoreGlobalMax)?Ampli:scoreGlobalMax;
      if (scoreLowMax != 0) {
        scoreLow = map(scoreLow, 0, scoreLowMax, 0, 20);
      } 
      if (scoreMidMax !=0) {
        scoreMid = map(scoreMid, 0, scoreMidMax, 0, 20);
      }
      if (scoreHiMax != 0) {
        scoreHi =  map(scoreHi, 0, scoreHiMax, 0, 20);
      }
      if (scoreGlobalMax !=0) {
        Ampli = map(Ampli, 0, scoreGlobalMax, 0, 15);
      }
      //println ("scoreLow ="+ scoreLow +"scoreMid="+scoreMid+"scoreHi"+scoreHi);
      // Voir en fonction de la music 
      //if ( frameCount % 5 == 0) {
      if ( random(1) < 0.2 ) {
        ps2.addParticles();
      }
      ps2.run(scoreLow, scoreMid, scoreHi, Ampli);
      break;
    }
  }
}
