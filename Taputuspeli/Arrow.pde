class Arrow {

  ArrayList arrows;

  FPoly arrowBody;

  Arrow(float elapsed_) {

    angle = atan2(arrowY-height, arrowX-indianX);

    float velfactor; 

    if (manualCrosshair)
      velfactor = 1+elapsed_/1000; //in seconds
    else
      velfactor = 2;

    arrowVelocity = new PVector(arrowX-indianX+aimShakeX, arrowY-height+aimShakeY);//(aimShakeX-indianX, aimShakeY-height);
    arrowBody = new FPoly();
    arrowBody.vertex(-14f, 0);
    arrowBody.vertex(0, -3f);
    arrowBody.vertex(6f, 0);
    arrowBody.vertex(0, 3f);
    arrowBody.setPosition(indianX, height);
    arrowBody.setVelocity(arrowVelocity.x*velfactor, arrowVelocity.y*velfactor);
    arrowBody.setRestitution(0.5);
    arrowBody.setFriction(0.5);
    arrowBody.setDensity(10);
    arrowBody.setRotation(angle);
    arrowBody.setBullet(true);
    arrowBody.attachImage(arrowimg);
    //println(angle);
    world.add(arrowBody);
    //arrows.add(arrowBody);
  }

  void update() {
    pushMatrix();
    arrowBody.resetForces();
    translate(arrowBody.getX(), arrowBody.getY());
    rotate(arrowBody.getRotation());
    PVector pointingDirection = new PVector(1, 0);
    pointingDirection.normalize();
    PVector flightVelocity = new PVector(arrowBody.getVelocityX(), arrowBody.getVelocityY());
    flightVelocity.normalize();
    float velLength = flightVelocity.mag();
    float dragConstant = 0.9;

    arrowBody.setRotation(atan2(arrowBody.getVelocityY(), arrowBody.getVelocityX()));

    if (arrowBody.getY() > height) {
      arrowContainer.removeArrow(arrowBody);
    }
    popMatrix();
  }

  FPoly getArrowBody() { 
    return arrowBody;
  }
}

//ARROWCONTAINER CLASS - CONTAINS ALL ARROWS

class ArrowContainer {

  ArrayList<Arrow> arrows;

  ArrowContainer() {
    arrows = new ArrayList<Arrow>();
  }

  void update() {
    //if(arrows.size() > 0)
    for (int i = 0; i < arrows.size(); i++) {
      arrows.get(i).update();
    }
  }

  void addArrow(float elapsed_) {
    arrows.add(new Arrow(elapsed_));
  }

  void removeArrow(FBody arrowBody_) {

    FPoly arrowBody = (FPoly)arrowBody_;

    for (int i = 0; i < arrows.size(); i++)
      if (arrows.get(i).getArrowBody() == arrowBody)
        arrows.remove(i);

    world.remove(arrowBody);
  }
}




