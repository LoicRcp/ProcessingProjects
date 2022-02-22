class dot {

  PVector pos;
  PVector vel;
  int id;
  int maxSpeed = 5;
  int rotateFactor=4;

  boolean dead = false;
  color dotColor = color(255);



  dot(PVector _pos, int _id) {
    pos = _pos;
    id = _id;
    vel = new PVector(random(-maxSpeed, maxSpeed), random(-maxSpeed, maxSpeed));
  }



  void showDot() {
    fill(dotColor);
    noStroke();
    circle(pos.x, pos.y, 4);
  }


  void moveDot() {

    if (!dead) {




      vel.rotate(random(-PI/rotateFactor, PI/rotateFactor));
      vel.limit(maxSpeed);
      pos.add(vel);

      if (checkCollision()) {
        pos = spawns.get(id).pos.copy();
      }
    }
  }

  void checkDeath() {
    map.loadPixels();


    // if ( random(0, 100) < dyingChancePercent  && brightness(map.pixels[int(pos.y)*width+int(pos.x)])!=255.0) {
    //  if ( random(0, 100) < dyingChancePercent  && map.pixels[int(pos.y)*width+int(pos.x)] != color(236,28,36)) {
    if ( random(0, 100) < dyingChancePercent  && map.pixels[int(pos.y)*width+int(pos.x)] != color(255)) {
      dead = true;
      dotColor = map.pixels[int(pos.y)*width+int(pos.x)];
    }
  }


  boolean checkCollision() {
    return (0 > pos.x || pos.x > width) || (0 > pos.y || pos.y > height);
  }
}
