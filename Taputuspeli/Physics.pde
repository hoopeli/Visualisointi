void contactStarted(FContact c) {
  FBody ball = null;

  if (c.getBody1() == obstacle) {
  } 
  else if (c.getBody2() == obstacle) {
    ball = c.getBody1();
  }
  else if (c.getBody2() == ground) {
  }
  else if (c.getBody1() == ground && c.getBody2() instanceof FPoly || c.getBody1() instanceof FBox && c.getBody2() instanceof FPoly) {
    FBody arrow2 = c.getBody2();
    arrowContainer.removeArrow(arrow2);
    snd[2].trigger();
    particle.addParticle(new PVector(c.getX(), c.getY()));
  }
  else if (c.getBody2() instanceof FCircle && c.getBody1() instanceof FPoly ) {
        
    snd[2].trigger();
    particle.addParticle(new PVector(c.getX(), c.getY()));
    

    FBody arrow1 = c.getBody1();
    FBody bird = c.getBody2();
    bird.adjustVelocity(0, 600);
    bird.dettachImage();
    bird.attachImage(deadangrybird);
    bird.setSensor(true);
    hits+=1;

    //birdContainer.killBird(bird);
    arrowContainer.removeArrow(arrow1);
    //world.remove(arrow1);
  }

  if (ball == null) {
    return;
  }

  ball.setFill(30, 190, 200);
}

void castRay() {
  FRaycastResult result = new FRaycastResult();
  FBody b = world.raycastOne(indianX, height-100, arrowX+1, arrowY, result, true);

  stroke(0, 100);
  //if (!manualCrosshair)
  //line(indianX, height, arrowX, arrowY);

  if (b != null) {
    b.setFill(120, 90, 120);
    fill(180, 20, 60);
    noStroke();

    float x = result.getX();
    float y = result.getY();
    ellipse(x, y, 10, 10);
  } 
  else {
    obstacle.setFill(0);
  }
}

