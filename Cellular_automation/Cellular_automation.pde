Cell cell;

void setup() {
  size(600, 600);
  cell = new Cell();
}

void draw() {
  cell.run();
}

class Cell {
  int[] cells;
  int[] rules = {0, 1, 0, 1, 1, 0, 1, 0};
  int round, resolution;

  Cell() {
    resolution = 10;
    round = 0;
    cells = new int[width/resolution];
    
    for (int i=0; i<cells.length; i++) {
      cells[i] = 0;
    }
    cells[cells.length/2] = 1;
  }

  int newState(int i, int j, int k) {
    int code = Integer.parseInt(str(i) + str(j) + str(k), 2);
    return rules[code];
  }

  void automation() {
    int[] nextCells = new int[cells.length];
    for (int i=1; i<cells.length-1; i++) {
      nextCells[i] = newState(cells[i-1], cells[i], cells[i+1]);
    }
    cells = nextCells;
    //rounds
    round++;
  }

  void draw() {
    for (int i=0; i<cells.length; i++) {
      if (cells[i] == 0) {
        fill(255);
      } else {
        fill(0);
      }
      rect(i*resolution, round*resolution, resolution, resolution);
    }
  }

  void run() {
    draw();
    automation();
  }
}
