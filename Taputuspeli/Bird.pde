class Bird {

  FCircle bird;
  PVector position;
  PVector velocity;

  Bird(PVector origin) { 
    //position = new PVector(origin.x,origin.y);
    position = new PVector(random(0, width), height);
    velocity = new PVector(random(-400, 400), random(-400, 0));

    bird = new FCircle(30);
    //angrybird.resize(0, 30); 
    bird.attachImage(angrybird);
    bird.setPosition(position.x, position.y);
    bird.setVelocity(velocity.x, velocity.y);
    bird.setRestitution(0.5);
    bird.setFriction(0.5);
    bird.setDensity(1);
    bird.setRotation(angle);
    bird.setBullet(true);
    world.add(bird);
  }

  void update() {
    position.x = bird.getX();
    position.y = bird.getY();
    bird.addForce(velocity.x, -400);
    constraints();
    birdDirectionArrow();
       
  }

  FCircle getBird() {
    return bird;
  }

  PVector getPosition() { 
    return position;
  }

  void constraints() {
    //CONSTRAINTS
    if (bird.getX() >= width) {
      velocity.x = -200;
      totheRight = !totheRight;
      //bird.addTorque(!totheRight ? -50:50);
    }
    if (bird.getY() >= height-100) {
      velocity.y = -5;
      //bird.setStatic(true);
      //bird.addTorque(!totheRight ? -50:50);
    }

    if (bird.getX() <= 0) {
      velocity.x = 200;
      totheRight = !totheRight;
      //bird.addTorque(!totheRight ? -50:50);
    }
    if (bird.getY() <=-50) {
      velocity.y = 0;
    }
  }

  void birdDirectionArrow() {

    fill(255, 0, 0, 100);
    //KUINKA KORKEALLA  LINTU ON
    ellipse(width-10, pos.y, 10, 10);
  }
}

class BirdContainer {

  ArrayList<Bird> birds;
  PVector birdorigin;

  BirdContainer() {
    birds = new ArrayList<Bird>();
    birdorigin = new PVector(width/2, height/2);
    birds.add(new Bird(birdorigin));
  }

  void update() {

    for (int i = 0; i < birds.size(); i++) {
      Bird b = birds.get(i);
      b.update();
      FCircle f = b.getBird();

      if (b.getPosition().y > height) {
        birds.remove(i);
        world.remove(f);
      }
    }
  }

  void addBird() {
    birds.add(new Bird(birdorigin));
  }

  void moveBirds(boolean moveup) {
    for (int i = 0; i < birds.size(); i++) {
      Bird b = birds.get(i);
      FCircle f = b. getBird();
      if (moveup)
        f.addForce(0, -1000);
      else
        //f.addForce(0,500);
        f.setVelocity(0, 0);
    }
  }

  void soundMove() {
    for (int i = 0; i < birds.size(); i++) {
      Bird b = birds.get(i);
      FCircle f = b. getBird();
      //f.adjustVelocity(random(-50,50), -10);
      f.addForce(500, -2000);
    }
  }

  void killBird(FBody bird) {
    FCircle bird_ = (FCircle)bird;
  }
}

