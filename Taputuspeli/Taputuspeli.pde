/**
 * This sketch demonstrates how to use the BeatDetect object song SOUND_ENERGY mode.<br />
 * You must call <code>detect</code> every frame and then you can use <code>isOnset</code>
 * to track the beat of the music.
 * <p>
 * This sketch plays an entire song, so it may be a little slow to load.
 */

import peasy.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioSource song;
BeatDetect beat;
HighPassSP lpf;
FFT fft;

AudioSample snd[]; //AudioSamples are "triggered" sounds
int currSnd; //simple counter


SoundAnalyzer soundanalyzer;
Background scrollingbackground;
ParticleSystem particle;
Crosshair crosshair;

import com.phidgets.*;
import com.phidgets.event.*;
import fisica.*;
import org.jbox2d.common.*;

FWorld world;
FBox obstacle;
FBox ground;
FPoly poly;
Bird bird;
BirdContainer birdcontainer;
Indian indian;

ArrowContainer arrowContainer;

InterfaceKitPhidget ik;


float eRadius;
float x, y;
int direction = 1;
PVector arrowVelocity, pos;
static int FREQ_ENERGY;
boolean totheRight = true;
color bandcolor;
boolean aiming = true;
boolean showcrosshair = true;
boolean disablesound = false;
boolean shoot = false;
boolean pressed = false;
boolean manualCrosshair = true;
boolean moveRight = true;

float aimShakeX = 0;   //KADEN TARINAN KOORDINAATIT;
float aimShakeY = 0;
float angle; 
float arrowX;
float arrowY;
float indianX;
int elapsed;

ArrayList arrows;

int startTimer;
float reduceCrosshair = 0;

PImage angrybird,deadangrybird;
PImage arrowimg;
PImage mountains;
PImage gorillaimg, gorillaimg1;
PImage bowdrawimg;

float cX, cY;
float pressedX,pressedY;

PVector birdvelocity;

boolean showJungle;

PeasyCam cam;

int hits;

void setup()
{
  size(1600, 800, P3D);


  //cam = new PeasyCam(this, width/2, height/2 , 0 , 700);

  soundanalyzer = new SoundAnalyzer();

  Fisica.init(this);

  //SOUNDANALYZER-----------------------------------------------------------------!!!!!!!!!!!!!!!!!!!!!!!!
  minim = new Minim(this);
  song = minim.getLineIn(Minim.STEREO, 1024);
  //song.play();
  // a beat detection object song SOUND_ENERGY mode with a sensitivity of 10 milliseconds
  beat = new BeatDetect(1024, 44000);
  beat.setSensitivity(0);
  //beat.detectMode(BeatDetect.FREQ_ENERGY);
  //lpf = new HighPassSP(100,1024);
  //song.addEffect(lpf);
  fft = new FFT(1024, 44000);
  fft.logAverages(20, 60);
  bandcolor = color(255, 0, 0);

  arrowVelocity = new PVector(1, 0);
  pos = new PVector(0, 0);

  particle = new ParticleSystem(new PVector(0, 0));

  scrollingbackground=new Background();

  crosshair = new Crosshair();
  reduceCrosshair = 0;
  

  angrybird = loadImage("angrybird.png");
  deadangrybird = loadImage("deadangrybird.png");
  arrowimg = loadImage("arrow.png");
  gorillaimg = loadImage("gorilla.png"); //gorilla left
  gorillaimg1 = loadImage("gorilla1.png"); //gorilla right
  bowdrawimg = loadImage("bowdraw1.png");
  arrowimg.resize(0, 6);



  createWorld();


  birdvelocity = new PVector(0, 0);
  birdcontainer = new BirdContainer();


  indian = new Indian();

  arrowContainer = new ArrowContainer();
  //arrows = new ArrayList<FPoly>();
  constrain(arrowY, 0, height);
  arrowY = height;
  arrowX = 0 ;

  mountains = loadImage("westlands.jpg");

  //setupIKP();

  showcrosshair = true;
  disablesound = true;
  showJungle = true;



  snd = new AudioSample[6]; //setup sample array
  for (int i=0; i < 6; i++) snd[i] = minim.loadSample(i+".wav"); //load few samples for variety
  currSnd = 0; //initialize the counter
  
  snd[5].trigger();
  snd[5].setGain(-20);
}

void draw()
{
  //println(frameRate);

  background(200, 243, 255);
  //tint(0, 153, 204, 255);

  float a = map(indianX, 0, width, 0, mountains.width-width);

  //image(mountains, 0, 0);

  world.step();

  particle.addParticle();
  particle.run();

  birdcontainer.update();

  if (showcrosshair)
    crosshair.update();

  world.draw();
  
  if(showJungle)
  scrollingbackground.display();

  arrowContainer.update();
  indian.update();

  castRay();

  if (!disablesound)
    soundanalyzer.update();

  aimingType();
  
  arrowX = mouseX;
  arrowY = mouseY;
  
  
 
}

void shoot(float elapsed_) {

  arrowContainer.addArrow(elapsed_);

  snd[4].stop();
  snd[currSnd].trigger(); //trigger the sound
  //currSnd = (currSnd + 1)%4; //increment the counterso different sound is played next
  //snd[2].trigger();
}

float getShotAngle() {
  return atan2(arrowY-height, arrowX-indianX);
}

void aimingType() {
  if (manualCrosshair) {
    if (pressed) {
      reduceCrosshair+=0.5;

      if (reduceCrosshair > 100)
        reduceCrosshair = 100;

      //TAHTAYSVIIVAT  
      /*float interpolate = reduceCrosshair/100;
       line(indianX, height, (1-interpolate)*indianX + (interpolate)*arrowX, (1-interpolate)*height + (interpolate)*arrowY);
       
       line(indianX, height, arrowX+50-reduceCrosshair/2, arrowY);
       line(indianX, height, arrowX-50+reduceCrosshair/2, arrowY);*/
      //arrowY -= 3;
    }
  }
  else {
    if (pressed) {
      arrowY -= 3;
      line(indianX, height, arrowX, arrowY);
      //arrowY = height;
      //arrowX = indianX;
    }
  }
}

void createWorld() {
  world = new FWorld();
  //world.setGravity(0,9.89);

  obstacle = new FBox(150, 150);
  obstacle.setRotation(PI/4);
  obstacle.setPosition(width/2, -100);
  obstacle.setStatic(true);
  obstacle.setFill(0);
  obstacle.setRestitution(0);
  obstacle.setGrabbable(true);

  ground = new FBox(width, 5);
  ground.setPosition(width/2, height);
  ground.setStatic(true);
  ground.setFill(0);
  ground.setRestitution(1);
  ground.setDensity(2);

  world.add(obstacle);
  world.add(ground);
}

void stop()
{
  // always close Minim audio classes when you are finished with them
  song.close();
  // always stop Minim before exiting
  minim.stop();

  super.stop();
}




