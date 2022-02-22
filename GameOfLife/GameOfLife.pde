Grid grid;

int cellSize = 25;
boolean pause = true;

void setup() {
  size(1000, 1000);
  frameRate(10);
  grid = new Grid(cellSize);
}

void draw() {
  background(80);
  if (!pause) {
    grid.displayGrid();
    grid.getNextState();
    grid.applyNextState();
  } else {
    grid.displayGrid();
  }
}

void keyPressed() {
  if (key == ' ') {   
    pause = !pause;
    if (!pause) {
      grid.getNextState();
      grid.applyNextState();
    }
  }
}

void mouseClicked() {
  Cell cell = grid.getCellAtPos(mouseX, mouseY);

  if (mouseButton == LEFT) {
    cell.state = true;
  }
  if (mouseButton == RIGHT) {
    cell.state =false;
  }
}
