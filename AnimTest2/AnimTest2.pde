class Horse{
  PImage image;
  PVector position;
  int frameRow;
  int frameColumn;
  float frameTimer;
  PVector velocity;
  float speed;
}
 
Horse horse;
float left = 0;
float right = 0;
  
void setup(){
  size(1200, 230);
  horse = new Horse();
  horse.image = loadImage("horse_sheet.png");
  horse.position = new PVector(0, 0);
  horse.velocity = new PVector(0, 0);
  horse.frameRow = 0; // mikä rivi lähdekuvasta
  horse.frameColumn = 0; // mikä kolumni lähdekuvasta
  horse.frameTimer = 0; // mikä kolumni animoidaan
  horse.speed = 4; // walk speed
}
 
void draw(){
  background(100);
  
  horse.velocity.x = horse.speed * (left + right);
  horse.position.add(horse.velocity);
   
  horse.frameTimer += 0.1; // animaation framerate
  if (horse.frameTimer >= 15){ // 15 rivii
    horse.frameTimer = 0;
  }
  horse.frameColumn = (int)horse.frameTimer; // heitetään timerista kokonaisluku
  
  if (left != 0){
    horse.frameRow = 1; // rivi 1 vasemmalle
  }
  if (right != 0){
    horse.frameRow = 0; // rivi 0 oikealle päin
  }
 
  //pushMatrix(); Ei tarvitakkaan kai
  translate(horse.position.x, horse.position.y);
   
  // Käytetään getSubImage-funktioo, joka tehtiin alempana.
  // sisään syötetään horse.image ja takas saadaan sopiva frame lähdekuvasta.
  // Framen koko, ja rivi + kolumni määritetään.
  PImage frameImage = getSubImage(horse.image, horse.frameRow, horse.frameColumn, 300, 200);
   
  // Piirretään tämä kuva horse.image:n sijaan
  image(frameImage, 0, 0);
   
  //popMatrix(); Ei tarvitakkaan kai
}
 
// Funktio, joka palauttaa pienemmän croppauksen alkuperäisestä kuvasta, eli framen
PImage getSubImage(PImage image, int row, int column, int frameWidth, int frameHeight){
  return image.get(column*frameWidth, row*frameHeight, frameWidth, frameHeight);
}
 
void keyPressed(){
  if (keyCode == RIGHT){
    right = 1;
    left = 0;
    horse.frameTimer +=2;
    horse.speed += 0.5;
  }
  if (keyCode == LEFT){
    left = -1;
    right = 0;
    horse.frameTimer +=1;
    horse.speed += 0.5;
  }
}

