// A simple Particle class

class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(random(-.5, 0.5), random(-0.5, 0.5));
    location = l.get();
    lifespan = 50.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update location
  void update() {
    velocity.add(acceleration);
    location.add(velocity);

    lifespan -= 10.0;
  }

  // Method to display
  void display() {
    stroke(255, lifespan);
    fill(255, lifespan);
    ellipse(location.x, location.y, 2, 2);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } 
    else {
      return false;
    }
  }
}

class HitParticle extends Particle
{
  color hitcolor;

  HitParticle(PVector l) {
    super(l);
    //lifespan = 255;
  }
  // Method to display
  void display() {
    stroke(200, 0, 0, lifespan);
    fill(255, 0, 0, lifespan);
    ellipse(location.x, location.y, 16, 16);
  }
}

// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  ArrayList<Particle> hitparticles;

  ParticleSystem(PVector location) {
    origin = location.get();
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    for (int i = 0; i < 5; i++)
      particles.add(new Particle(origin));
  }

  void addParticle(PVector position) {
    for (int i = 0; i < 50; i++)
      particles.add(new HitParticle(position));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
    
    ArrayList<Arrow> arrows_ = arrowContainer.getArrows();
    if(arrows_.size() > 0){
      for(int i = 0; i < arrows_.size(); i++){
     Arrow arrow_ = arrows_.get(i);
     origin = arrow_.getPos();}
    }else
    origin = new PVector(indianX, height);
  }
}

