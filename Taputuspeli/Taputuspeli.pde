/**
  * This sketch demonstrates how to use the BeatDetect object song SOUND_ENERGY mode.<br />
  * You must call <code>detect</code> every frame and then you can use <code>isOnset</code>
  * to track the beat of the music.
  * <p>
  * This sketch plays an entire song, so it may be a little slow to load.
  */
 
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
 
Minim minim;
AudioSource song;
BeatDetect beat;
HighPassSP lpf;
FFT fft;

Background scrollingbackground;

ParticleSystem crosshair;
 
float eRadius;
float x,y;
int direction = 1;
PVector vel, pos;
static int FREQ_ENERGY;
boolean totheRight = true;
color bandcolor;
boolean aiming = true;

 float _x = 0;   //KADEN TARINAN KOORDINAATIT;
  float _y = 0;
 
void setup()
{
  size(1200, 600, P3D);
  minim = new Minim(this);
  song = minim.getLineIn(Minim.STEREO,1024);
  //song.play();
  // a beat detection object song SOUND_ENERGY mode with a sensitivity of 10 milliseconds
  beat = new BeatDetect(1024,44000);
  beat.setSensitivity(0);
 //beat.detectMode(BeatDetect.FREQ_ENERGY);
  //ellipseMode(CENTER_RADIUS);
  eRadius = 20;
  x=0;
  y=height-20;
  rect(x,y,20,20);
  
  vel = new PVector(1,0);
  pos = new PVector(0,0);
  
  //lpf = new HighPassSP(100,1024);
  //song.addEffect(lpf);
  fft = new FFT(1024, 44000);
  fft.logAverages(22,5);
  //rectMode(CORNERS);
  bandcolor = color(255,0,0);
  
  crosshair = new ParticleSystem(new PVector(0,0));
  
  scrollingbackground=new Background();
 

}
 
void draw()
{
  background(0);
  scrollingbackground.display();
  //DRAWSIDE
  crosshair.addParticle();
  crosshair.run();
  
  
  //SOUNDSIDE
  beat.detect(song.mix);
  float a = map(eRadius, 20, 80, 60, 255);
  
  fill(bandcolor);
  if (fft.getBand(28) > 50 || fft.getBand(29) > 50 || fft.getBand(30) > 50){      //song.mix.level() > 0.3){ 
    bandcolor = color(0,0,255,a);
    eRadius = 180;
    float directionvelpos = (fft.getBand(28)+fft.getBand(29))/2000;
    PVector factor = new PVector(0,(pos.y-mouseY));
    factor.normalize();
    vel.add(new PVector(directionvelpos,-directionvelpos/2*factor.y)); 
    
  }else if(fft.getBand(5) > 50 || fft.getBand(4) > 50 || fft.getBand(3) > 50 || fft.getBand(6) > 50){
    bandcolor = color(0,255,0,a);
    eRadius = 180; 
    float directionvelneg = -(fft.getBand(5)+fft.getBand(3)+fft.getBand(3)+fft.getBand(6))/400;
    PVector factor = new PVector(0,(pos.y-mouseY));
    factor.normalize();
    vel.add(new PVector(directionvelneg,directionvelneg/2*factor.y)); 
    
    
  }
  
  stroke(255);
  line(0,400,width,400);
  line(0,550,width,550);
  
  ellipse(mouseX, mouseY, eRadius, eRadius);
  eRadius *= 0.99;
  vel.mult(0.99);
  if ( eRadius < 20 ) eRadius = 20;
  
   
  pos.add(new PVector(totheRight ? 0.98:-0.98,0.98));
  pos.add(vel);
  fill(255,0,0);
  
  rectMode(CORNER);
  
  ellipse(pos.x,pos.y,20,20);
  
  //CONSTRAINTS
  if(pos.x+20 >= width){
    pos.x = width-20;
    vel.x -= 5;
  }
 if(pos.y+20 >= height){
    pos.y = height-20;
    vel.y -= 5;
  }
  
  if(pos.x <= 0){
    pos.x = 0;
    vel.x += 5;
  }
  if(pos.y <=-50){
    
    vel.y += 5;
  }
  
  //FFT
  rectMode(CORNERS);
  fft.forward(song.mix);
  int w = int(width/fft.avgSize());
  for (int i = 0; i < fft.avgSize(); i++) //specSize()
  {
   if(i == 28 || i==29 || i==30)
   fill(0,0,255);
   else if(i==5 || i == 4 || i == 3 || i == 6)
   fill(0,255,0);
   else
   fill(255,0,0);
   // draw the line for frequency band i, 
   // scaling it by 4 so we can see it a bit better
   //line(i, height, i, height - fft.getBand(i) * 4);
   rect(i*w,height,i*w+w,height-fft.getAvg(i));
  }

  ellipse(width-10,pos.y,10,10);
  
  beginShape();
  
  if(totheRight){
  vertex(width/2,height*0.90);
  vertex(width/2,height*0.90+20);
  vertex(width/2+20,height*0.90);
  
  vertex(width/2,height*0.90);
  vertex(width/2,height*0.90-20);
  vertex(width/2+20,height*0.90);
  }
  else{
  vertex(width/2,height*0.90);
  vertex(width/2,height*0.9+20);
  vertex(width/2-20,height*0.90);
  
  vertex(width/2,height*0.90);
  vertex(width/2,height*0.9-20);
  vertex(width/2-20,height*0.90);
  }
  endShape();
  
  //println(song.mix.level());
  //if(song.mix.level() > 0.3)
  //println("JEEEEEEEEEEEEEEEEEEEEEEE");
  /*println("RIGHT BAND " + fft.getBand(28));
  println("LEFT BAND " + fft.getBand(5));
  println("SONG MIX LEVEL: " + song.mix.level());*/
  //println("mouseX: " + mouseX);
  //println("mouseY: " + mouseY);
  //println(fft.getAvg(28));
  
  
 
  float r = eRadius/2;
  
  pushMatrix();
  
  float rSquared = r*r;
  translate(mouseX,mouseY);
  if(aiming){ 
  _x=random(-r,r);
  _y=random(-1,1)*sqrt(rSquared-_x*_x);
  ellipse(_x,_y,5,5);
  //setHitpoint(_x,_y);
  }else{
   fill(255,224,50,150);
   ellipse(_x,_y,20,20);
  }
  
  popMatrix();
  
  if(pos.x > mouseX+_x-10 && pos.x < mouseX+_x+10 && pos.y > mouseY+_y-10 && pos.y < mouseY+_y+10){
    rectMode(CENTER);
    fill(0);
    rect(mouseX+_x,mouseY+_y,20,20);
  }
  
  line(width/2,height,mouseX,mouseY);

 
}

void mousePressed()
{  
  float a = map(eRadius, 20, 80, 60, 255);
  PVector yfactor = new PVector(0,pos.y-mouseY);
  yfactor.normalize();
  
  if
  (mouseButton == LEFT){
    aiming=!aiming;
    totheRight = false;
    bandcolor = color(0,255,0,a);
    eRadius = 180;
    float directionvelneg = -2;
    vel.add(new PVector(directionvelneg,directionvelneg/1.5*yfactor.y)); 
  }
  else if
  (mouseButton == RIGHT){
    aiming=!aiming;
  totheRight = true;
  bandcolor = color(0,0,255,a);
    eRadius = 180;
    float directionvelpos = 2;
    vel.add(new PVector(directionvelpos,-directionvelpos/1.5*yfactor.y)); 
  }
  else if
  (mouseButton == CENTER){
    aiming=!aiming;
  }
}
 
void stop()
{
  // always close Minim audio classes when you are finished with them
  song.close();
  // always stop Minim before exiting
  minim.stop();
 
  super.stop();
}
