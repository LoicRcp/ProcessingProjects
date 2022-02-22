
Ball ball;

Trou[] trous = new Trou[4];

void setup() {
  size(600, 300);
  frameRate(60);
  background(80);
  PVector location = new PVector(width/4, height/2);
  float ballWidth = 16;
  
  ball = new Ball(location, ballWidth);

  trous[0] = new Trou(new PVector(0, 0), 32);
  trous[1] = new Trou(new PVector(width, 0), 32);
  trous[2] = new Trou(new PVector(0, height), 32);
  trous[3] = new Trou(new PVector(width, height), 32);
}



void draw() {
  background(20, 100, 20);

  stroke(255);
  if (ball != null) {
    if (abs(ball.velocity.x) < 0.05 && abs(ball.velocity.y) < 0.05) {
      line(ball.location.x, ball.location.y, mouseX, mouseY);
    }

    // FRICTION
    float frictionCoef = 8;
    float normalForce = 1;
    float frictionMag = frictionCoef*normalForce;
    PVector friction = ball.velocity.copy();
    friction.normalize();
    friction.mult(-1);
    friction.mult(frictionMag);

    ball.applyForce(friction);

    ball.drawBall();
    ball.moveBall();
    ball.bounceBall();
  }
  for (Trou trou : trous) {
    trou.display();
    if (ball != null) {
      trou.checkCollisionWithBall();
    }
  }
}

void mouseClicked() {
  PVector speedVec = new PVector(-(mouseX - ball.location.x)/20, -(mouseY - ball.location.y)/20);
  ball.acceleration = speedVec;
}
