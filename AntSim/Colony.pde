class Colony {


  PVector pos;
  int size;
  int colonyNb;
  Ant[] colonyAnts;
  int colonyRadius = 25;

  Colony(PVector _pos, int _size, int _colonyNb) {
    pos = _pos;
    size = _size;
    colonyNb = _colonyNb;

    colonyAnts = new Ant[size];
    for (int i = 0; i < size; i++) {
      // colonyAnts[i] = new Ant(new PVector(int(random((width/2)-200, (width/2)+200)), int(random((height/2)-200, (height/2)+200))), 1, i);
      colonyAnts[i] = new Ant(pos.copy(), 1, i);
    }

    for (int i = (int)pos.x-colonyRadius; i<pos.x+colonyRadius; i++) {
      for (int j = (int)pos.y-colonyRadius; j<pos.y+colonyRadius; j++) {
        if (pow((i - pos.x),2) + pow((j - pos.y),2) < pow(colonyRadius,2)){
          pheromonGrid[i][j] = new pheromon(new PVector(i,j), "toBase", true);
        }
      
      }
    }
    
  }






  void update() {

    for (int i = 0; i < size; i++) {
      colonyAnts[i].updateMovement();
      colonyAnts[i].display();
      colonyAnts[i].dropPheromon();
    }

    //colonyAnts[50].dropPheromon();
  }

  void display() {
    fill(100, 100, 200, 100);
    circle(pos.x, pos.y, colonyRadius*2);
  }
}
