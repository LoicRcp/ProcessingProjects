int gridCellSize = 5; //<>//
float healthyRate = 0.7;
float sickRate = 0;
float immunisedRate = 0.30;
float resistanceRate = 0.99;
int recoveryTime = 50;
int deathTime = 100 ;
float infectiosity = 0.01;
int stepCounter = 0;
float immunityRate = 0.1;


cells[] grid = new cells[int(sq((1000/gridCellSize)))];




void setup() {
  size(1000, 1000);
  background(80);
  frameRate(60);
  int x, y;
  int i = -1;

  for (y = 0; y < height; y = y + gridCellSize) {
    for (x = 0; x < width; x = x + gridCellSize) {
      i++;
      grid[i] = new cells(x, y, gridCellSize, i);
      if (i == 998) {
        println("test");
      }
    }
  }

  for (int g = 0; g < grid.length; g++) {
    grid[g].identifyNeighbor();
  }


  grid[(grid.length/2)+((1000/gridCellSize)/2)].type = "sick";
  //grid[(55)].type = "sick";
  // grid[int(random(grid.length))].type = "sick";
}

void draw() {

  for (int g = 0; g < grid.length; g++) {
    grid[g].identifyType();
    grid[g].checkNeighbors();
    grid[g].update();
    grid[g].display();
  }


  textAlign(CENTER);
  textSize(15);
  fill(0);
  text(stepCounter, 20, 20);
  stepCounter++;
}

void keyPressed() {
  if (keyCode == BACKSPACE) {
    for (int g = 0; g < grid.length; g++) {
      grid[g].identifyType();
      grid[g].checkNeighbors();
      grid[g].update();
    }
    stepCounter++;
  }
}


void mouseClicked() {
  float lowestDist = 10000;
  float distanceCellMouse;
  int nearestCell = 0;
  for (int i = 0; i < grid.length; i++) {
    distanceCellMouse =  dist(mouseX, mouseY, (grid[i].x+(grid[i].size/2)), (grid[i].y + (grid[i].size/2)));
    if (distanceCellMouse < lowestDist) {
      lowestDist = distanceCellMouse;
      nearestCell = grid[i].number;
    }
  }
  if (mouseButton == LEFT) {
    grid[nearestCell].type = "sick";
  } else if (mouseButton == RIGHT) {
    grid[nearestCell].type = "healthy";
  }
}
