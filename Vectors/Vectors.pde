Mover[] movers = new Mover[20];

void setup() {
  size(800, 600);
  //Multiple objects
  for (int i=0; i<movers.length; i++) {
    movers[i] = new Mover(20, 20);
    movers[i].setup();
  }
}

void draw() {
  for (Mover m : movers) {
    m.move();
    m.checkEdge();
    m.display();
  }
}

class Mover {
  PVector position, velocity, acceleration;
  float w, h, topSpeed;
  int fillColor;

  Mover(float _w, float _h) {
    w = _w;
    h = _h;
    fillColor = randomColor();
    position = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);
    acceleration = PVector.random2D();
    topSpeed = 10;
  }

  void setup() {
    fill(fillColor);
    ellipse(position.x, position.y, w, h);
  }

  void move() {
    //Towars mouse
    PVector des = new PVector(mouseX, mouseY);
    PVector dir = des.sub(position);
    dir.normalize();
    acceleration = dir.mult(0.5);
    velocity.add(acceleration);
    //Max speed limit
    velocity.limit(topSpeed);
    position.add(velocity);
  }

  void display() {
    fill(fillColor);
    ellipse(position.x, position.y, w, h);
  }

  //Check edge
  void checkEdge() {
    if (position.x < 0 || position.x > width) {
      velocity.x *= -1;
      acceleration.x *= -1;
    } else if (position.y < 0 || position.y > height) {
      velocity.y *= -1;
      acceleration.y *= -1;
    }
  }

  //Random color
  int randomColor() {
    return color(random(255), random(255), random(255));
  }
}
