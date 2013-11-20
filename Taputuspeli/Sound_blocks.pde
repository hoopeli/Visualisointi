class SoundAnalyzer {


  SoundAnalyzer() {
  }

  void update() {

    fft.forward(song.mix);

    if (fft.calcAvg(0, 200) > 20)
      birdcontainer.soundMove();

    //FFT
    println("AVG ALL " + fft.calcAvg(0, 3200));
    println("A " + fft.calcAvg(0, 200));
    println("B " + fft.calcAvg(200, 400));
    println("C " + fft.calcAvg(400, 800));
    println("D " + fft.calcAvg(800, 1200));
    println("E " + fft.calcAvg(1200, 1600));
    println("F " + fft.calcAvg(1600, 2000));
    println("G " + fft.calcAvg(2000, 2400));
    println("H " + fft.calcAvg(2400, 2800));
    println("I " + fft.calcAvg(2800, 3200));

    println("LOW " + fft.getBand(75));
    println("HIGH " + fft.getBand(400));

    rectMode(CORNERS);
    int w = int(width/fft.avgSize());

    for (int i = 0; i < fft.avgSize(); i++) //specSize()
    {
      if (i > 350 && i < 450)
        fill(0, 0, 255);
      else if (i > 50 && i < 150)
        fill(0, 255, 0);
      else
        fill(255, 0, 0);
      // draw the line for frequency band i, 
      // scaling it by 4 so we can see it a bit better
      //line(i, height, i, height - fft.getBand(i) * 4);
      rect(i*w, height, i*w+w, height-fft.getAvg(i));
    }
  }
}

/*
//SOUNDSIDE
 beat.detect(song.mix);
 float a = map(eRadius, 20, 80, 60, 255);
 
 if (fft.getBand(9) > 50 || fft.getBand(10) > 50) {//(fft.getBand(28) > 50 || fft.getBand(29) > 50 || fft.getBand(30) > 50) {      //song.mix.level() > 0.3){ 
 
 eRadius = 180;
 
 float directionvelpos = 6;
 //PVector factor = new PVector(0, (pos.y-mouseY));
 PVector factor = new PVector(0,1);
 factor.normalize();
 birdvelocity.add(new PVector(directionvelpos, -directionvelpos*factor.y));
 totheRight = true;
 }
 else if (fft.getBand(5) > 50 || fft.getBand(4) > 50 || fft.getBand(3) > 50 || fft.getBand(6) > 50) {
 
 eRadius = 180; 
 
 float directionvelneg = 6;
 //PVector factor = new PVector(0, (pos.y-mouseY));
 PVector factor = new PVector(0,1);
 factor.normalize();
 birdvelocity.add(new PVector(directionvelneg, directionvelneg*factor.y));
 totheRight = false;
 }
 */

//println(song.mix.level());
//if(song.mix.level() > 0.3)
//println("JEEEEEEEEEEEEEEEEEEEEEEE");
/*println("RIGHT BAND " + fft.getBand(28));
 println("LEFT BAND " + fft.getBand(5));
 println("SONG MIX LEVEL: " + song.mix.level());*/
//println("mouseX: " + mouseX);
//println("mouseY: " + mouseY);
//println(fft.getAvg(28));

