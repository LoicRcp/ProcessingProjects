boolean blink;

class circleCell {
  int delai = millis() + int(random(1000,5000));
  
  int borderBlinkColor;
  float x, y, diameter; 
  float urge = 0;
  int number;
  circleCell(float tempX, float tempY, float tempDiameter, int tempNumber) {
    x = tempX;
    y = tempY;
    diameter = tempDiameter;
    number = tempNumber;
  }
  circleCell(int tempNumber) {
    x = random(diameter/2,width-diameter);
    y = random(diameter/2,height-diameter);
    diameter = 100;
    number = tempNumber;
  }

  void display() {
    if (borderBlinkColor >0){
    borderBlinkColor += -2;}
    else if (borderBlinkColor < 0){
      borderBlinkColor = 0;}
      stroke(borderBlinkColor,0,0);
    fill(131,131+urge,131);
    circle(x, y, diameter);
    if (HUD == true){

    textAlign(CENTER);
    textSize(10);
    fill(0);
    text(number, x,y);
    text(urge, x, y +(diameter/4));
    }
  }

  void delai() {
    if (delai <= millis()){
      randomDelai = true;
    
    } else { randomDelai = false;
    
     
   }
  }

float blinkDelai;
  void update() {
    urge = urge +1;
    //urge = lerp(urge, 100, 0.1);
    if (urge >= 100) {
      for (int i = 0; i < grid.length; i++) {
        
        grid[i].mouseClick(x, y);
        blinkArray[number] = true;
      }
      urge = 0;
    }

    
  


}

void reset(){
  delai = millis() + int(random(1000,5000));
  urge = 0;
}




void increaseUrge(){
  urge = urge + (urge*0.1);
  borderBlinkColor = 255;
  
  
  
}



}
