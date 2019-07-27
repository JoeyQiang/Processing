Vehicle v1, v2;
FlowField field;
PVector force;

void setup() {
  size(600, 600);
  field = new FlowField();
  v1 = new Vehicle(20, 20); 
}

void draw() {
  force = field.returnForce(int(v1.position.y/field.resolution), int(v1.position.x/field.resolution));
  v1.applyForce(force);
  v1.run();
}

class FlowField {
  PVector[][] field;
  int rows, cols, resolution;

  FlowField() {
    resolution = 10;
    rows = int(width/resolution);
    cols = int(height/resolution);
    field = new PVector[rows][cols];
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        field[i][j] = PVector.random2D();
      }
    }
  }

  PVector returnForce(int _row, int _col) {
    int row = int(constrain(_row, 0, rows-1));
    int col = int(constrain(_col, 0, cols-1));
    return field[row][col];
  }
}

class Vehicle {
  PVector position, destination, velocity, acceleration;
  float w, h, maxSpeed, maxForce, r;

  Vehicle(float _w, float _h) {
    w = _w;
    h = _h;
    position = new PVector(random(width), random(height));
    velocity = new PVector(random(1), random(1));
    acceleration = new PVector(0, 0);
    maxSpeed = 10;
    maxForce = 10;
    r = 15;
  }

  void seek(PVector _des) {
    destination = _des.copy();
    PVector desired = PVector.sub(destination, position);
    float dis = desired.mag();
    desired.normalize();
    if (dis < 100) {
      dis = map(dis, 0, 100, 0, maxSpeed);
      desired.mult(dis);
    } else {
      desired.mult(maxSpeed);
    }
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    applyForce(steer);
  }

  void applyForce(PVector _force) {
    acceleration.add(_force);
  }

  void move() {
    velocity.add(acceleration);
    //Max speed limit
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    //Since triangle is drawn pointing up, heading is pointing right, so adding PI/2
    float theta = velocity.heading() + PI/2;
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape();
    vertex(0, -r);
    vertex(-0.5*r, r);
    vertex(0.5*r, r);
    endShape();
    popMatrix();
  }

  void checkEdge() {
    if (position.x < 0 || position.x > width) {
      velocity.x *= -1;
    } else if (position.y < 0 || position.y > height) {
      velocity.y *= -1;
    }
  }

  void run() {
    move();
    display();
    checkEdge();
  }
}
