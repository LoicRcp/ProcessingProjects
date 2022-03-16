class boxObstacle extends obstacle{
  
  int boxWidth, boxHeight;
  
  boxObstacle(PVector _pos, int _boxWidth, int _boxHeight){
    super(_pos);
    boxWidth = _boxWidth;
    boxHeight = _boxHeight;
    
    
  }
  
  
  float distance(PVector explorerPos){
    
    PVector boxCenter = new PVector (pos.x + boxWidth, pos.y + boxHeight);
    
    PVector offset = explorerPos.copy().sub(boxCenter);
    offset.x = abs(offset.x);
    offset.y = abs(offset.y);
    offset = offset.sub(new PVector(boxWidth, boxHeight));
    
    float unsignedDst = new PVector(max(offset.x, 0), max(offset.y, 0)).mag();
    float dstInsideBox = min(max(offset.x, offset.y), 0);

    
    return unsignedDst + dstInsideBox;
    
    
    

  }
  
  
  void show(){
   fill(0);
   stroke(0);
   rect(pos.x, pos.y, boxWidth*2, boxHeight*2);  
  }
  
  
  
  
}
