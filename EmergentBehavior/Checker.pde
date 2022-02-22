class checker {

  float x, y, diameter;
  int number;


  checker(int tempNumber) {
    number = tempNumber;
    x = circleCell[number].x;
    y = circleCell[number].y;
    diameter = 200;
  }

  void display() {
   if (checkerStroke == false) {
    noStroke();}
   else if (checkerStroke == true) {
    stroke(255);}
    noFill();
    circle(x, y, diameter);
  }

  void update(){
   x = circleCell[number].x;
   y = circleCell[number].y;
    
  }

  boolean checkOverlap(float x2, float y2, float diameter2) {
    if (dist(x, y, x2, y2) <= diameter/2 + diameter2/2) {
      return true;
    } else {
      return false;
    }
  }
}
