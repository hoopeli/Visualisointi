void mouseMoved() {
  
  //arrowX = mouseX;
 // arrowY = mouseY;
  
}

void mousePressed()
{  
  float a = map(eRadius, 20, 80, 60, 255);
  PVector yfactor = new PVector(0, pos.y-mouseY);
  yfactor.normalize();

  if
  (mouseButton == LEFT) {
    pressed = true;
    startTimer = millis();
    elapsed = 0;
  }
  else if
  (mouseButton == RIGHT) {
    aiming=!aiming;
    totheRight = true;
    eRadius = 180;
  }
  else if
  (mouseButton == CENTER) {
    aiming=!aiming;
  }
  
}

void mouseReleased(){
    elapsed = millis() - startTimer;
    shoot(elapsed);
    reduceCrosshair = 0;
    pressed = false;
}

void keyPressed() {
  if(key == 'q')
    showJungle = !showJungle;
  if (key == 'a')
    indianX-=10;
  if (key == 'd')
    indianX+=10;
  if (key == 'c')
    showcrosshair = !showcrosshair;
  if (key == 'x')
    disablesound = !disablesound;
  if (key == 'v')
    manualCrosshair = !manualCrosshair;
  if (key == 'b')
    birdcontainer.addBird();
  if (key == 'n')
    createTree();
  if (key == 'm')
    birdcontainer.moveBirds(true);
  if (key == 'k')
    birdcontainer.moveBirds(false);
  if (key == 't')
    println("BIRD AMOUNT " + birdcontainer.getBirds().size());

  //KEYBOARD CROSSBOX DRAW 
  if (key == 'f') {
    pressed = true;
    startTimer = millis();
    elapsed = 0;
  } 
  if (key == 'g') {
    elapsed = millis() - startTimer;
    shoot(elapsed);
    reduceCrosshair = 0;
    pressed = false;
  }
}

void keyReleased(){
    if(key == 'q'){    
    pressedX = arrowX;
    pressedY = arrowY;
    arrowX = constrain(mouseX,pressedX-100,pressedX+100);
    arrowY = constrain(mouseY,pressedY-100,pressedY+100);
  }
}

void createTree() {
  FBox tree = new FBox(50, height/2);
  tree.setPosition(random(0, width), height);
  tree.setStatic(true);
  tree.setFill(0);
  //tree.setRestitution(1);
  //tree.setDensity(2);  
  tree.setGrabbable(true);
  tree.setSensor(true);

  world.add(tree);
}

