class pheromon {

  PVector pos;
  String type;

  int time = millis();

  int strenght = 255;

  pheromon(PVector _pos, String _type) {
    pos = _pos;
    type = _type;
    
  }

  void show() {
    noStroke();
    
    
    if (type == "red") {
      fill(255, 50, 50, strenght);
    } else if (type == "blue") {
      fill(50, 50, 255, strenght);
    }
    
    
    
    circle(pos.x, pos.y, 4);
    
    
  }
  
  void update(){
    if (millis() > time + 10);{
      strenght-= 5;
      if (strenght <= 0){
       pheromonGrid[(int)pos.x][(int)pos.y] = null; 
      }
      
    }
    
    
    
  }
  
}
