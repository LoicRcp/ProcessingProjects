class pheromon {

  PVector pos;
  String type;

  int time = millis();
  boolean permanent;
  int strenght = 255;

  pheromon(PVector _pos, String _type) {
    pos = _pos;
    type = _type;
    permanent = false;
  }
  
  pheromon(PVector _pos, String _type, boolean _permanent) {
    pos = _pos;
    type = _type;
    permanent = _permanent;
  }

  void show() {
    noStroke();
    
    
    if (type == "toFood") {
      fill(255, 50, 50, strenght);
    } else if (type == "toBase") {
      fill(50, 50, 255, strenght);
    }
    
    
    
    circle(pos.x, pos.y, 2);
    
    
  }
  
  void update(){
    if (millis() > time + 200 && !permanent){
      strenght-= 5;
      if (strenght <= 0){
       pheromonGrid[(int)pos.x][(int)pos.y] = null; 
      }
      time = millis();
    }
    
    
    
  }
  
}
