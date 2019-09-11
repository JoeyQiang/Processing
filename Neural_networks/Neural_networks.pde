//Perception perc;
//Testset[] testsets = new Testset[2000];
//int count = 0;

//void setup() {
//  size(600, 600);
//  for (int i=0; i<testsets.length; i++) {
//    testsets[i] = new Testset();
//  }
//  perc = new Perception();
//}

//float fn(float x) {
//  return x;
//}

//void draw() {
//  background(255);
//  //Make the weights to be accurate
//  perc.train(testsets[count]);
//  count = (count+1) % testsets.length;

//  for (int i=0; i<count; i++) {
//    //Above the line or below the line
//    int guess = perc.feedforward(testsets[i]);

//    //print(guess);
//    if (guess > 0) {
//      fill(0);
//    } else {
//      noFill();
//    }
//    ellipse(testsets[i].inputs[0], testsets[i].inputs[1], 10, 10);
//  }
//}


//class Perception {
//  float[] weights;
//  int weights_num = 2;
//  float learning_rate = 0.001;

//  Perception() {
//    weights = new float[weights_num];
//    for (int i=0; i<weights.length; i++) {
//      weights[i] = random(-1, 1);
//    }
//  }

//  //Positve: fill(0), negative: fill(255)
//  int feedforward(Testset testset) {
//    float sum = 0;
//    for (int i=0; i<weights.length; i++) {
//      sum += testset.inputs[i]*weights[i];
//    }
//    if (sum >= 0) {
//      //Positive
//      return 1;
//    } else {
//      //Negative
//      return -1;
//    }
//  }

//  void train(Testset testset) {
//    float error = testset.answer - feedforward(testset);
//    print(error);
//    for (int i=0; i<weights.length; i++) {
//      weights[i] += testset.inputs[i] * error * learning_rate;
//    }
//  }
//}

//class Testset {
//  float[] inputs;
//  float answer;
//  Testset() {
//    inputs = new float[2];
//    inputs[0] = random(width);
//    inputs[1] = random(height);
//    if (fn(inputs[0]) - inputs[1]>0) {
//      answer = 1;
//    } else {
//      answer = -1;
//    }
//  }
//}

Network network;

void setup() {
  size(900, 360);
  background(255);
  network = new Network(width/2, height/2);

  Neuron a = new Neuron(-400, 0);
  Neuron b = new Neuron(-200, 0);
  Neuron c = new Neuron(0, -100);
  Neuron d = new Neuron(0, 100);
  Neuron e = new Neuron(200, 0);
  Neuron f = new Neuron(400, 0);

  network.addNeuron(a);
  network.addNeuron(b);
  network.addNeuron(c);
  network.addNeuron(d);
  network.addNeuron(e);
  network.addNeuron(f);

  network.connect(a, b);
  network.connect(b, c);
  network.connect(b, d);
  network.connect(c, e);
  network.connect(d, e);
  network.connect(e, f);

  network.display();
}

void draw() {
  background(255);

  network.update();
  network.display();

  //30 frames trigger an input
  if (frameCount % 30 == 0) {
    network.feedForward(random(1));
  }
}

class Network {
  PVector position;
  ArrayList<Neuron> neurons;
  Network(float _x, float _y) {
    position = new PVector(_x, _y);
    neurons = new ArrayList<Neuron>();
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y);
    for (Neuron n : neurons) {
      n.display();
      for (Connection c : n.cList) {
        c.display();
      }
    }
    popMatrix();
  }

  void update() {
    for (Neuron n : neurons) {
      for (Connection c : n.cList) {
        c.update();
      }
    }
  }

  void addNeuron(Neuron n) {
    neurons.add(n);
  }

  void connect(Neuron start, Neuron end) {
    Connection c = new Connection(start, end, random(1));
    start.addConnection(c);
  }

  void feedForward(float val) {
    Neuron start = neurons.get(0);
    start.feedForward(val);
  }
}

class Neuron {
  PVector position;
  ArrayList<Connection> cList = new ArrayList<Connection>();
  float sum = 0;
  Neuron(float _x, float _y) {
    position = new PVector(_x, _y);
  }
  void display() {
    fill(0);
    ellipse(position.x, position.y, 20, 20);
    for (Connection c : cList) {
      c.display();
    }
  }
  void addConnection(Connection c) {
    cList.add(c);
  }
  void feedForward(float val) {
    sum += val;
    if (sum > 1) {
      fire();
      sum = 0;
    }
  }
  void fire() {
    for (Connection c : cList) {
      //Suppose fire sum
      c.feedForward(sum);
    }
  }
}

class Connection {
  Neuron start, end;
  float weight;
  boolean sending = false;
  PVector sender;
  float output = 0;
  float amt = 0;

  Connection(Neuron s, Neuron e, float w) {
    start = s;
    end = e;
    weight = w;
  }

  void display() {
    stroke(0);
    strokeWeight(weight);
    line(start.position.x, start.position.y, end.position.x, end.position.y);

    if (sending) {
      //Draw the circle
      ellipse(sender.x, sender.y, 8, 8);
    }
  }

  void feedForward(float val) {
    sending = true;
    sender = start.position.copy();
    output = val * weight;
  }

  void update() {

    if (sending) {

      amt += 0.1;
      sender.x = lerp(start.position.x, end.position.x, amt);
      sender.y = lerp(start.position.y, end.position.y, amt);

      float dist = PVector.dist(sender, end.position);

      if (dist < 1) {
        //Pass from start to end
        end.feedForward(output);
        sending = false;
        amt = 0;
      }
    }
  }
}
