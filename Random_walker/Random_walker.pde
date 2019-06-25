Walker w;

void setup() {
  size(800, 600);
  w = new Walker(width/2, height/2, 30, 30);
  //w.setup();
}

void draw() {
  w.update();
  w.move();
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
    x_pos = map(noise(tx), 0, 1, 0, width);
    y_pos = map(noise(ty), 0, 1, 0, height);
    tx += 0.01;
    ty += 0.01;
  }

  void move() {
    ellipse(x_pos, y_pos, w, h);
  }
}
