class dotSpawnPoint{
  
  PVector pos;
  int id;
  
  
  dotSpawnPoint(PVector _pos, int _id){
    pos = _pos;
    id = _id;
    println(id);
  }
  
  void show(){
    fill(0);
    noStroke();
    circle(pos.x, pos.y, 16);
  }
  
  
  
}
