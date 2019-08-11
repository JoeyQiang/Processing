//ArrayList<Dotline> lines;
float length = 100;

void setup() {
  size(600, 600);
  translate(width/2, height);
  branch(length);
  //tree = new Tree(0, 0, 100);
  //tree.branch();
  //Snow dot lines
  //lines = new ArrayList<Dotline>();
  //PVector start = new PVector(0, height/2);
  //PVector end = new PVector(width, height/2);
  //lines.add(new Dotline(start, end));
  //for (int i=0; i<5; i++) {
  //  generate();
  //}
  //Circle style
  //drawCircle(width/2, height/2, 300);

  //Snow style
  //for (Dotline l : lines) {
  //  l.display();
  //}
}

void draw() {
}

//void generate() {
//  ArrayList next = new ArrayList<Dotline>();
//  for (Dotline l : lines) {

//    PVector a = l.DotA();
//    PVector b = l.DotB();
//    PVector c = l.DotC();
//    PVector d = l.DotD();
//    PVector e = l.DotE();

//    print(a);
//    print(b);
//    print(c);
//    print(d);
//    print(e);

//    next.add(new Dotline(a, b));
//    next.add(new Dotline(b, c));
//    next.add(new Dotline(c, d));
//    next.add(new Dotline(d, e));
//  }
//  lines = next;
//}

//Circle recursion
//void drawCircle(float x, float y, float r) {
//  stroke(0);
//  noFill();
//  ellipse(x, y, r, r);
//  if(r > 8){
//     drawCircle(x+r/2, y, r/2);
//     drawCircle(x-r/2, y, r/2);
//  }
//}

//class Dotline {
//  PVector start, end;
//  Dotline(PVector s, PVector e) {
//    start = s.copy();
//    end = e.copy();
//  }
//  void display() {
//    line(start.x, start.y, end.x, end.y);
//  }
//  PVector DotA() {
//    return start.copy();
//  }
//  PVector DotB() {
//    PVector b = start.copy();
//    PVector l = PVector.sub(end, start);
//    b.add(l.mult(1).div(3));
//    return b;
//  }
//  PVector DotC() {
//    PVector c = start.copy();
//    PVector l = PVector.sub(end, start);
//    l.mult(1).div(3);
//    c.add(l);
//    l.rotate(-radians(60));
//    c.add(l);
//    return c;
//  }
//  PVector DotD() {
//    PVector d = start.copy();
//    PVector l = PVector.sub(end, start);
//    d.add(l.mult(2).div(3));
//    return d;
//  }
//  PVector DotE() {
//    return end.copy();
//  }
//}

void branch(float length) {
  line(0, 0, 0, 0 - length);
  translate(0, -length);
  length *= 0.9;
  if (length > 5) {

    pushMatrix();
    rotate(radians(random(0,20)));
    branch(length*random(0.5,1));
    popMatrix();

    pushMatrix();
    rotate(radians(random(-20,0)));
    branch(length*random(0.5,1));
    popMatrix();
  }
}
