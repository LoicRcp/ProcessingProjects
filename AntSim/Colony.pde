class Colony {


  PVector pos;
  int size;
  int colonyNb;
  Ant[] colonyAnts;
  float colonyRadius = 100;

  Colony(PVector _pos, int _size, int _colonyNb) {
    pos = _pos;
    size = _size;
    colonyNb = _colonyNb;

    colonyAnts = new Ant[size];
    for (int i = 0; i < size; i++) {
      // colonyAnts[i] = new Ant(new PVector(int(random((width/2)-200, (width/2)+200)), int(random((height/2)-200, (height/2)+200))), 1, i);
      colonyAnts[i] = new Ant(pos.copy(), 1, i);
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

  void display(){
   fill(100,100,200,100);
   circle(pos.x,pos.y,colonyRadius);
    
    
  }


}
