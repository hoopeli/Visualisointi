class Indian {

  FBox indianBody;

  Indian() {
    indianBody = new FBox(50, 50);
    indianBody.setPosition(width/2, height-50);
    indianBody.setVelocity(40, 0);
    indianBody.setRestitution(1);
    indianBody.setRotatable(false);
    //indianBody.setFriction(0.5);
    indianBody.setDensity(1);
    world.add(indianBody);
  }

  void update() {

    rectMode(CENTER);
    rect(indianX, height, 50, 50);

    //EASING BOX
    float targetX = indianX;
    float dx = targetX - indianBody.getX();
    if (abs(dx) > 1)
      indianBody.adjustVelocity(dx*0.005, 0);

    if (manualCrosshair) {
      //fill(255,0,0,80);
      //ellipse(arrowX,arrowY,100-reduceCrosshair,100-reduceCrosshair);
    }

    drawCrossbow();
  }

  void drawCrossbow() {
    //CROSSBOW    
    pushMatrix();
    translate(indianX, height);
    rotate(atan2(arrowY-height, arrowX-indianX)+PI/2);
    ellipse(0, 0, 20, 20);
    noFill();
    stroke(255);
    strokeWeight(3);
    beginShape();
    vertex(-30, -60+reduceCrosshair/2);
    bezierVertex(-20, -80, 20, -80, 30, -60+reduceCrosshair/2);
    endShape();

    beginShape();
    strokeWeight(1);
    vertex(-30, -60+reduceCrosshair/2);
    bezierVertex(0, -60+reduceCrosshair, 0, -60+reduceCrosshair, 30, -60+reduceCrosshair/2);
    endShape();

    if (pressed)
      line(0, -60+reduceCrosshair, 0, -110+reduceCrosshair);
    popMatrix();
  }
}

class Crosshair {

  Crosshair() {
  }

  void update() {
    fill(255, 0, 0, 100);
    ellipse(arrowX, arrowY, 100-reduceCrosshair, 100-reduceCrosshair);//(mouseX, mouseY, eRadius, eRadius);
    //ellipse(mouseX, mouseY, 100-reduceCrosshair, 100-reduceCrosshair);
    eRadius *= 0.99;

    if ( eRadius < 20 ) eRadius = 20;

    //CROSSHAIR SIZE
    pushMatrix();
    float r = (100-reduceCrosshair)/2;//eRadius/2;
    float rSquared = r*r;
    translate(arrowX, arrowY);//(mouseX, mouseY);
   
    if (pressed) { 
      aimShakeX=random(-r, r);
      aimShakeY=random(-1, 1)*sqrt(rSquared-aimShakeX*aimShakeX);
      fill(0, 0, 255, 100);
      ellipse(aimShakeX, aimShakeY, 5, 5);
      //setHitpoint(aimShakeX,aimShakeY);
    }
    else {
      fill(255, 224, 50, 150);
      ellipse(aimShakeX, aimShakeY, 20, 20);
      
    }

    popMatrix();

  }
}

