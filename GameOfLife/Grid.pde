class Grid {


  Cell[][] grid;



  int lignes, colonnes, cellSize;

  Grid(int _cellSize) {
    cellSize = _cellSize; 
    lignes = width/cellSize;
    colonnes = height/cellSize;
    grid = new Cell[lignes][colonnes];

    for (int i = 0; i<lignes; i++) {
      for (int j = 0; j<lignes; j++) {
        grid[i][j] = new Cell(i, j);
      }
    }
  }


  void displayGrid() {
    for (int i = 0; i<lignes; i++) {
      for (int j = 0; j<lignes; j++) {
        if (grid[i][j] != null) {
          grid[i][j].display();
        }
      }
    }
  }

  void getNextState() {
    for (int i = 0; i<lignes; i++) {
      for (int j = 0; j<lignes; j++) {
        if (grid[i][j] != null) {
          grid[i][j].applyRules();
        }
      }
    }
  }
  void applyNextState() {
    for (int i = 0; i<lignes; i++) {
      for (int j = 0; j<lignes; j++) {
        if (grid[i][j] != null) {
          grid[i][j].state = grid[i][j].nextState;
        }
      }
    }
  }


  Cell getCellAtPos(int x, int y) {

    x = round(x);
    y = round(y);

    x = x - x%cellSize;
    y = y - y%cellSize;

    int xIndex = x/cellSize;
    int yIndex = y/cellSize;

    return(grid[xIndex][yIndex]);
  }
}
