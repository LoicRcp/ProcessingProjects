class Robot { //<>// //<>// //<>// //<>//


  Point pos;
  PVector angle;
  boolean move = false;
  boolean rotate = false;
  PVector destination;
  boolean rotateStart = true;

  Robot(float _x, float _y) {
    pos = new Point(_x, _y, false);

    angle = PVector.random2D();
    angle.rotate(random(0, 2*PI));
  }


  void show() {

    stroke(0);
    fill(100, 255, 100);
    circle(pos.x, pos.y, 32);

    line (pos.x, pos.y, pos.x + angle.x*16, pos.y + angle.y * 16);
  }

  void robotRotate() {

    //PVector d1 = angle.copy().add(new PVector(x,y).sub(new PVector(x,y)));
    PVector d1 = angle;
    PVector d2;
    if (rotateStart) {
      d2 = new PVector(destination.x, destination.y).sub(new PVector(pos.x, pos.y));
    } else {
      d2 = trajectoire[nextPoint-1].angle;
    }
    float angle1 = atan2(d1.x, d1.y);
    float angle2 = atan2(d2.x, d2.y);
    //float toRotate = lerp(angle.heading(),angle1-angle2,0.000005);
    float toRotate = (angle1-angle2);
    angle.rotate((toRotate)/10);
    if (abs(toRotate) < 0.05) {
      rotate = false;
    }
  }

  void moveToPoint() {

    pos.x = pos.x * (1 - 0.05) + destination.x * 0.05;
    pos.y = pos.y * (1 - 0.05) + destination.y * 0.05;

    //x = lerp(x,destination.x,0.05);
    //y = lerp(y,destination.y,0.05);  

    if ((destination.x-2 < pos.x && pos.x < destination.x+2) && (destination.y-2 < pos.y && pos.y < destination.y+2)) {
      move = false; 
      rotate = true;
      if (!trajectoire[nextPoint-1].obstacle) {
        rotateStart = false;
      }
    }
  }
}
