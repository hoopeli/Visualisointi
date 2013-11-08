class Background{

PImage img;
int x_,y_;
boolean scrollRight;

Background()
  {
   scrollRight = true;
   img = loadImage("level.jpg"); // image is 1600 x 600
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

  if(vel.x > 0)
  x_+=0.5;
  else if(vel.x<0)
  x_-=0.5;
  
  image(img, -pos.x, 0);//-x_, 0);
  
   // advances the image with each new frame
     // do whatever is wanted from here on 
     // like after a call of background();
  stroke(0,0,0);
  
}

float getOrigin(){
  return x_;
}



}
