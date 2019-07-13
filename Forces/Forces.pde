Mover[] movers = new Mover[10];
//PVector G = new PVector(0, 0.1);
//PVector wind = new PVector(0.01, 0);
//PVector fraction, velocity;

void setup() {
  size(600, 600);
  //Multiple objects
  for (int i=0; i<movers.length; i++) {
    movers[i] = new Mover(40, 40, random(0.1, 2));
  }
}

void draw() {
  //Gravity, wind, fraction
  //for (Mover m : movers) {
  //velocity = m.velocity.get();
  //fraction = velocity.mult(-1).normalize().mult(0.01);
  //m.applyForce(G.mult(m.m));
  //m.applyForce(wind);
  //m.applyForce(fraction);
  //  m.move();
  //  m.display();
  //  m.checkEdge();
  //}

  //Universal gravitation
  PVector force;
  for (int i = 0; i < movers.length; i++) {
    for (int j = 0; j < movers.length; j++) {
      if (i!=j) {
        force = movers[j].attrat(movers[i]);
        movers[i].applyForce(force);
      }
    }
    movers[i].move();
    movers[i].display();
    //movers[i].checkEdge();
  }
}

class Mover {
  PVector position, velocity, acceleration, force;
  //width, height, topSpeed, mass
  float w, h, topSpeed, m;

  Mover(float _w, float _h, float _m) {
    w = _w;
    h = _h;
    m = _m;
    position = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    topSpeed = 10;
  }

  void applyForce(PVector _force) {
    force = _force.copy();
    acceleration.add(force.div(m));
  }

  void move() {
    velocity.add(acceleration);
    //Max speed limit
    velocity.limit(topSpeed);
    position.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    ellipse(position.x, position.y, w, h);
  }

  PVector attrat(Mover _mover) {
    PVector force = PVector.sub(position, _mover.position);
    float dis = constrain(force.mag(), 5, 25);
    float c = (m * _mover.m) / (dis * dis);
    force.normalize();
    force.mult(c);
    return force;
  }

  //Check edge
  void checkEdge() {
    if (position.x < 0 || position.x > width) {
      velocity.x *= -1;
    } else if (position.y < 0 || position.y > height) {
      velocity.y *= -1;
    }
  }
}
