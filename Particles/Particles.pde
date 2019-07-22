ParticleSystems pss = new ParticleSystems(); //<>//

void setup() {
  size(800, 800);
  pss.setup();
}

void draw() {
  pss.run();
}

class ParticleSystems {
  ArrayList<ParticleSystem> pss = new ArrayList<ParticleSystem>();
  int size = 5;

  ParticleSystems() {
  }

  void setup() {
    for (int i = 0; i < size; i++) {
      ParticleSystem ps = new ParticleSystem(random(width), random(height));
      pss.add(ps);
    }
  }

  void run() {
    ParticleSystem ps;
    for (int i = pss.size()-1; i >= 0; i--) {
      ps = pss.get(i);
      ps.run();
    }
  }
}

class ParticleSystem {
  ArrayList<Particle> ps = new ArrayList<Particle>();
  float x, y;
  float lifespan = 255;

  ParticleSystem(float _x, float _y) {
    x = _x;
    y = _y;
  }

  void run() {
    float ran = random(1);
    if (ran < 0.33) {
      ps.add(new Particle(x, y));
    } else if (ran < 0.66) {
      ps.add(new RectParticle(x, y));
    } else {
      ps.add(new TriParticle(x, y));
    }

   
    Particle p;
    for (int i = ps.size()-1; i >= 0; i--) {
      p = ps.get(i);
      //Polymorphism
      p.run();
      if (p.isDead()) {
        ps.remove(i);
      }
    }
    lifespan -= 1.5;
  }

  boolean isDead() {
    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }
}

class Particle {
  PVector position, velocity, acceleration;
  float  lifespan = 255;

  Particle(float x, float y) {
    position = new PVector(x, y);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    acceleration = new PVector(0, 0.05);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.5;
  }

  void display() {
    stroke(255, lifespan);
    fill(255, lifespan);
    ellipse(position.x, position.y, 10, 10);
  }

  void run() {
    update();
    display();
  }

  boolean isDead() {
    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }
}


//Inheritance
class RectParticle extends Particle {

  RectParticle(float _x, float _y) {
    super(_x, _y);
  }

  void display() {
    stroke(100, lifespan);
    fill(100, lifespan);
    rect(position.x, position.y, 10, 10);
  }
}


class TriParticle extends Particle {

  TriParticle(float _x, float _y) {
    super(_x, _y);
  }

  void display() {
    stroke(0, lifespan);
    fill(0, lifespan);
    triangle(position.x, position.y, position.x-10, position.y+10, position.x+10, position.y+10);
  }
}
