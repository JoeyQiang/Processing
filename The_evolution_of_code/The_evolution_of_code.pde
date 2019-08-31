Face[] faces;
ArrayList<Face> matingPool;
float[] target = {0.85, 0.95, 0.8, 0.49, 0.25, 0.25, 0.25, 0.25, 0.15, 0, 0, 0, 0.4, 0.2, 0.8, 0.15};
float mutationRate = 0.01;
int populationNumber = 1000;
int displayNumber = 5;
Button btn;

void setup() {
  size(1300, 600);
  faces = new Face[populationNumber];
  btn = new Button(100, height-50);
  btn.display();
  for (int i=0; i<faces.length; i++) {
    faces[i]= new Face();
  }
  populationShow();
}

void draw() {
  btn.ifOver(mouseX, mouseY);
  //matingPool = new ArrayList<Face>();
  //for (int i=0; i<faces.length; i++) {
  //  faces[i].dna.fitness();
  //  for (int j=0; j<faces[i].dna.fitness; j++) {
  //    matingPool.add(faces[i]);
  //  }
  //}
  //for (int i=0; i<faces.length; i++) {
  //  Face father = matingPool.get((int)random(matingPool.size()));
  //  Face mother = matingPool.get((int)random(matingPool.size()));
  //  faces[i].dna = father.dna.crossOver(mother.dna);
  //  faces[i].dna.mutation();
  //  print(population[i].getPhrase());
  //}
}

void populationShow() {  
  for (int i=0; i<displayNumber; i++) {
    pushMatrix();
    translate((width/displayNumber*i)+85, height/2);
    faces[i].display();
    fill(0, 0, 0);
    text("Fitness:"+faces[i].dna.fitness(), 0, -200);
    popMatrix();
  }
}

void mousePressed() {
  //Event listener
  if (btn.ifOver) {
    btn.rounds++;
    //Iteration
    matingPool = new ArrayList<Face>();
    for (int i=0; i<faces.length; i++) {
      faces[i].dna.fitness();
      for (int j=0; j<faces[i].dna.fitness; j++) {
        matingPool.add(faces[i]);
      }
    }
    background(255, 255, 255);
    for (int i=0; i<faces.length; i++) {
      Face father = matingPool.get((int)random(matingPool.size()));
      Face mother = matingPool.get((int)random(matingPool.size()));
      faces[i].dna = father.dna.crossOver(mother.dna);
      //faces[i].dna.mutation();
    }
    populationShow();
    btn.display();
  }
}

class DNA {
  //char[] genes;
  float[] genes;
  int fitness;

  DNA() {
    //Class build function can read glocal variable
    fitness = 0;
    //genes = new char[target.length()];
    genes = new float[target.length];
    for (int i=0; i<genes.length; i++) {
      //ASCLL code for all chars, inclusing space
      //genes[i] = (char)random(32, 128);
      genes[i] = (float)round(random(0, 1)*100)/100;
    }
  }

  int fitness() {
    fitness = 0;
    for (int i=0; i<genes.length; i++) {
      //if (genes[i]==target.charAt(i)) {
      //  fitness += 1;
      //}
      if (abs(genes[i]- target[i]) < 0.01) {
        fitness += 1;
      }
    }
    return fitness;
  }

  DNA crossOver(DNA partner) {
    DNA crossGene = new DNA();
    int midPoint = (int)random(genes.length);
    for (int i=0; i<genes.length; i++) {
      if (i < midPoint) {
        crossGene.genes[i] = genes[i];
      } else {
        crossGene.genes[i] = partner.genes[i];
      }
    }
    return crossGene;
  }

  void mutation() {
    for (int i=0; i<genes.length; i++) {
      if (random(1) < mutationRate) {
        //genes[i] = (char)random(32, 128);
        genes[i] = (float)round(random(0, 1)*100)/100;
      }
    }
  }

  //char[] transferred to string
  //String getPhrase() {
  //  return new String(genes);
  //}
}

class Face {
  DNA dna;

  Face() {
    dna = new DNA();
  }

  void display() {
    //85
    float r = map(dna.genes[0], 0, 1, 0, 100);
    //rgb(242,203,126)
    dna.genes[1] = map(dna.genes[1], 0, 1, 0, 255); 
    dna.genes[2] = map(dna.genes[2], 0, 1, 0, 255); 
    dna.genes[3] = map(dna.genes[3], 0, 1, 0, 255); 
    color bg = color(dna.genes[1], dna.genes[2], dna.genes[3]);
    //-25
    float eye_left_x = -map(dna.genes[4], 0, 1, 0, 100);
    //-25
    float eye_left_y = -map(dna.genes[5], 0, 1, 0, 100);
    //25
    float eye_right_x = map(dna.genes[6], 0, 1, 0, 100);
    //-25
    float eye_right_y = -map(dna.genes[7], 0, 1, 0, 100);
    //15
    float eye_size = map(dna.genes[8], 0, 1, 0, 100);
    //rgb(0,0,0)
    dna.genes[9] = map(dna.genes[9], 0, 1, 0, 255); 
    dna.genes[10] = map(dna.genes[10], 0, 1, 0, 255); 
    dna.genes[11] = map(dna.genes[11], 0, 1, 0, 255); 
    color dec_bg = color(dna.genes[9], dna.genes[10], dna.genes[11]);
    //-40
    float mouth_x = -map(dna.genes[12], 0, 1, 0, 100);
    //20
    float mouth_y = map(dna.genes[13], 0, 1, 0, 100);
    //80
    float mouth_width = map(dna.genes[14], 0, 1, 0, 100);
    //15
    float mouth_height = map(dna.genes[15], 0, 1, 0, 100);

    //face
    fill(bg);
    ellipse(0, 0, r, r);
    //eye_left
    fill(dec_bg);
    rect(eye_left_x, eye_left_y, eye_size, eye_size);
    //eye_right
    rect(eye_right_x, eye_right_y, eye_size, eye_size);
    //mouth
    rect(mouth_x, mouth_y, mouth_width, mouth_height);
  }
}

class Button {
  float x, y, w, h;
  color bg;
  boolean ifOver;
  String text;
  int rounds;

  Button(float _x, float _y) {
    x = _x;
    y = _y;
    w = 100;
    h = 40;
    bg = color(255, 255, 255);
    ifOver = false;
    text = "Click to iterate";
    rounds = 0;
  }

  boolean ifOver(float mouse_x, float mouse_y) {
    if (mouse_x > x && mouse_x < x+w && mouse_y > y && mouse_y < y+h) {
      ifOver = true;
    } else {
      ifOver = false;
    }
    return ifOver;
  }

  void display() {
    fill(255, 255, 255);
    rect(x, y, w, h);
    fill(0, 0, 0);
    text(text, x+w/2-textWidth(text)/2, y+h/2+textDescent());
    text("#" + rounds, x, y);
  }
}
