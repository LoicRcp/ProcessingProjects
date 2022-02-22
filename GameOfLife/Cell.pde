  class Cell { //<>//


  Boolean state;
  Boolean nextState;
  int indexI, indexJ, x, y;


  Cell(int _i, int _j) {
    state = false;
    indexI = _i;
    indexJ = _j;
    x = indexI * (width/(width/cellSize));
    y = indexJ * (height/(height/cellSize));
  }




  void display() {
    if (state)fill(200, 200, 200);
    else fill(20, 20, 20);
    square(x, y, cellSize);
  }


  int NeighboorNumber() {
    int aliveNeighboor = 0;
    for (int i = -1; i <=1; i++) {
      for (int j = -1; j <=1; j++) {
        try {          
          boolean neighboorState = grid.grid[indexI+i][indexJ+j].state;
          boolean notSelf = (i!=0 || j!=0);
          if (neighboorState && notSelf) {
            aliveNeighboor++;
          }
        } 
        catch (ArrayIndexOutOfBoundsException e) {
        }
      }
    }
    return aliveNeighboor;
  }
  

  void applyRules() {
    int aliveNeighboor = NeighboorNumber();
    if (aliveNeighboor >=4 || aliveNeighboor <= 1) nextState = false;
    if (state == false && aliveNeighboor == 3) nextState = true;
    if ((state == true && (aliveNeighboor == 2 || aliveNeighboor ==3)) || state == false && aliveNeighboor != 3) nextState = state;
  }
}
