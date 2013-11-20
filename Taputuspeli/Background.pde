class Background {

  PImage img,img2;
  int x_, y_;
  boolean scrollRight;

  Background()
  {
    scrollRight = true;
    img = loadImage("level2.png"); // image is 1600 x 600
    img2 = loadImage("level2.png");
  }
  void display()
  {

    //  background(0); 
    // not needed as image is bigger than size 
    // and thus overwrites all areas
    //x_ = constrain(x_, 0, img.width - width);    
    // ensures that "scrolling" stops at right end of image
    // y = constrain(y, 0, img.height - height); 
    // Not needed here, as scolling only in x

    float prev = indianX;


    x_+=1;
    println(x_);

    image(img, -x_, 100);//-x_, 0);
    
    if(x_ > img.width-width){
    pushMatrix();
    translate(img.width,0);
    image(img2,-x_,100);
    popMatrix();}

    // advances the image with each new frame
    // do whatever is wanted from here on 
    // like after a call of background();
    //stroke(0,0,0);
  }

  float getOrigin() {
    return x_;
  }
  
  void setX(int x){
    x_ = x;
  }
}

