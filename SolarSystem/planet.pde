class planet{
  
  PVector pos;
  int revolutionTime;
  int size;
  color clr;
  planet(PVector _pos, int _revolutionTime, int _size, color _clr){
    
    pos = _pos;
    revolutionTime = _revolutionTime;
    size = _size;
    clr = _clr;
  }
  
  
  
  
  void showPlanet(){
    noStroke();
    fill(clr);
   circle( pos.x, pos.y, size);
    
  }
  
  void movePlanet(){
   
    
    
    
    
    
   pos = pos.rotate(TWO_PI/revolutionTime*2); 
    
  }
  
  
}
