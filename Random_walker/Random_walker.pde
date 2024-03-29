Walker w;

void setup() {
  size(800, 600);
}

void draw() {
  //no trace moving
  //background(255);
  //after w is crated, call update/move function
  if (w != null) {
    w.update();
    w.move();
  }
}

//click to dicide origin_x & origin_y
void mousePressed() {
  w = new Walker(mouseX, mouseY, 30, 30);
}

class Walker {
  float x_pos, y_pos, w, h;
  float tx, ty;
  
  Walker(int origin_x, int origin_y, int _w, int _h) {
    tx = 0;
    ty = 10000;
    x_pos = origin_x;
    y_pos = origin_y;
    w = _w;
    h = _h;
  }

  void update() {
    x_pos += map(noise(tx), 0, 1, -2, 2);
    y_pos += map(noise(ty), 0, 1, -2, 2);
    tx += 0.01;
    ty += 0.01;
  }

  void move() {
    ellipse(x_pos, y_pos, w, h);
  }
}
