class explorer{
 
  
  PVector pos;
  
  explorer(){
   pos = new PVector(0,0); 
  }
  
  
  
  
  void show(){
    //noStroke();
    fill(255);
   circle(pos.x, pos.y, 8); 
    
  }
  
  void move(){
   pos.x = mouseX;
   pos.y = mouseY;
  }
  
}
