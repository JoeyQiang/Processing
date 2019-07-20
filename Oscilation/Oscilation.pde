//Mover[] movers = new Mover[1];
//Ocilation sin/cos
//float x, y, angle, amplitude;
//Pendelum movement
Bob bob;
Pendulum pendulum;
PVector gravity, pullForce;

void setup() {
  size(600, 600);
  pendulum = new Pendulum(1, 100, 50, 50);
  bob = new Bob(10, 20, 20);
  gravity = new PVector(0, 10);
  //Multiple objects
  //for (int i=0; i<movers.length; i++) {
  //  movers[i] = new Mover(random(40), random(40));
  //}
  //angle = 1;
  //amplitude = 100;
}

void draw() {
  bob.applyForce(gravity.mult(bob.m));
  bob.applyForce(pendulum.pullForce(bob));
  bob.move();
  bob.display(pendulum);
  pendulum.display();
  //for (Mover m : movers) {
  //  m.move();
  //  m.display();
  //}
  //background(255);
  //beginShape();
  //for (int x=0; x<width; x+=10) {
  //  y = amplitude * sin(angle) + height/2;
  //  vertex(x,y);
  //  angle += 0.1;
  //}
  //endShape();
}

class Mover {
  PVector position, velocity, acceleration;
  //width, height, topSpeed
  float w, h, topSpeed;
  float aVelocity, aAcceleration, angle;


  Mover(float _w, float _h) {
    w = _w;
    h = _h;
    position = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);
    acceleration = new PVector(random(-0.1, 0.1), random(-0.1, 0.1));
    aAcceleration = 0.01;
    aVelocity = 0;
    topSpeed = 2;
  }

  void move() {
    acceleration = new PVector(random(-0.1, 0.1), random(-0.1, 0.1));
    velocity.add(acceleration);
    //Max speed limit
    velocity.limit(topSpeed);
    position.add(velocity);
    checkEdge();
    //Rotate at the fixed speed
    //aVelocity += aAcceleration;
    //angle += aVelocity;
    //The angle of the speed
    angle = velocity.heading();
  }

  void display() {
    pushMatrix();
    rectMode(CENTER);
    translate(position.x, position.y);
    rotate(angle);
    rect(0, 0, w, h);
    popMatrix();
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

class Bob {
  PVector position, velocity, acceleration;
  float m, w, h, maxspeed;

  Bob(float _m, float _w, float _h) {
    m = _m;
    w = _w;
    h = _h;
    position = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    maxspeed = 10;
  }
  void applyForce(PVector force) {
    acceleration.add(force.div(m));
  }
  void move() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    acceleration.mult(0);
  }

  void display(Pendulum _pen) {
    line(position.x, position.y, _pen.position.x, _pen.position.y);
    ellipse(position.x, position.y, w, h);
  }
}


class Pendulum {
  float k, length, w, h, maxLength;
  PVector position;

  Pendulum(float _k, float _length, float _w, float _h) {
    k = _k;
    length = _length;
    w = _w;
    h = _h;
    position = new PVector(width/2, 50);
    maxLength = 200;
  }

  PVector pullForce(Bob _bob) {
    PVector force = new PVector(0, 0);
    PVector dir = PVector.sub(position, _bob.position);  
    float dis = dir.mag();
    
    dir.normalize();

    if (dis >= length) {
      force = dir.mult(k * (dis - length));
    }
 
    return force;
  }

  void display() {
    ellipse(position.x, position.y, w, h);
  }
}
