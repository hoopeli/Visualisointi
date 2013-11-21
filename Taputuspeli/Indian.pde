class Indian {

  FBox indianBody;
  FBox gorilla;

  Indian() {
    indianBody = new FBox(80, 120);
    indianBody.setPosition(width/2, height-120);
    indianBody.setVelocity(40, 0);
    indianBody.setRestitution(1);
    indianBody.setRotatable(false);
    indianBody.attachImage(gorillaimg);
    //indianBody.setFriction(0.5);
    indianBody.setDensity(1);
    indianBody.setBullet(true);
    indianBody.setSensor(true);
    world.add(indianBody);
    
    gorilla = new FBox(80, 120);
    gorilla.setPosition(width/2+200, height-120);
    gorilla.setVelocity(60, 0);
    gorilla.setRestitution(1);
    gorilla.setRotatable(false);
    gorilla.attachImage(gorillaimg);
    gorilla.setFriction(0.5);
    gorilla.setDensity(1);
    gorilla.setBullet(true);
    gorilla.setSensor(true);
    world.add(gorilla);
  }

  void update() {

    rectMode(CENTER);
    //drect(indianX, height, 50, 50);

    //EASING BOX
    float targetX = indianX;
    float dx = targetX - indianBody.getX();
    if (abs(dx) > 1){
      indianBody.adjustVelocity(dx*0.005, 0);
    }
    

    if(indianBody.getVelocityX() > 0)
      indianBody.attachImage(gorillaimg1);
    else 
      indianBody.attachImage(gorillaimg);
      
        //EASING BOX
    float targetX1 = indianX;
    float dx1 = targetX1 - gorilla.getX();
    if (abs(dx1) > 1){
      gorilla.adjustVelocity(dx1*0.010, 0);
    }
      
     if(gorilla.getVelocityX() > 0)
      gorilla.attachImage(gorillaimg1);
    else 
      gorilla.attachImage(gorillaimg);
      
      //println("INDIAN VELOCITY " + indianBody.getVelocityX());
      //println("GORILLA VELOCITY " + gorilla.getVelocityX());
      //println("DX " + abs(dx));
      //println("DX1 " + abs(dx1));
     

    if (manualCrosshair) {
      //fill(255,0,0,80);
      //ellipse(arrowX,arrowY,100-reduceCrosshair,100-reduceCrosshair);
    }

    drawCrossbow();
    String si = str(hits);
    fill(0);
    text(si ,0,10);
  }

  void drawCrossbow() {
    

    //CROSSBOW    
    pushMatrix();
    translate(indianX, height);
    
    float angle = atan2(arrowY-height, arrowX-indianX)+PI/2;
    
    rotate(angle);
    
    float drawMax = reduceCrosshair;
    
    if(drawMax > 45)
    drawMax = 45;
    
   
    
    imageMode(CENTER);
    if(angle < 0)
    scale(-1,1);
    image(bowdrawimg, 0,-50); 
    imageMode(CORNER);
    
    ellipse(0, 0, 20, 20);
    noFill();
    stroke(255);
    strokeWeight(3);
    beginShape();
    vertex(-80, -60+drawMax/2);
    bezierVertex(-40, -120, 40, -120, 80, -60+drawMax/2);
    endShape();

    beginShape();
    strokeWeight(1);
    vertex(-80, -60+drawMax/2);
    bezierVertex(0, -60+drawMax, 0, -60+drawMax, 80, -60+drawMax/2);
    endShape();
    
    
    if (pressed){
      stroke(193,131,42);
     strokeWeight(14);
    line(5, 30+drawMax, 5, -60+drawMax);
    ellipse(5,-70+drawMax*1.05,5,20);
    rotate(-PI/2);
    scale(1.7,1);
    image(arrowimg,  50-drawMax, 0);
    strokeWeight(1);
    
    }
    
    
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

