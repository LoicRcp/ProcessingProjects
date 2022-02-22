class Point {

  float x;
  float y;
  PVector angle;
  boolean obstacle;
  Point(float _x, float _y, boolean _obstacle) {

    x = _x;
    y = _y;
    obstacle = _obstacle;
    angle = PVector.random2D();
    angle.rotate(random(0, 2*PI));
  }

  void show() {
    stroke(0);
    circle(x, y, 16);
    stroke(0, 0, 255);
    line (x, y, x + angle.x*8, y + angle.y * 8);
  }
}
