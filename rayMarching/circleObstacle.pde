class circleObstacle extends obstacle{
  
  int radius;
  
  circleObstacle(PVector _pos, int _radius){
    super(_pos);
    pos = _pos;
    radius = _radius;
    
    
  }
  
  float distance(PVector explorerPos){
    PVector result = pos.copy().sub(explorerPos.copy());
    return result.mag() - radius; 
  }
  
  void show(){
   fill(0);
   stroke(0);
   circle(pos.x, pos.y, radius*2);  
  }
  
  
  
  
}
