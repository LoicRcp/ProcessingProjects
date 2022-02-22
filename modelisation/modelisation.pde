Robot robot; //<>//
Point SA, SB, A, D;
int maxPoints = 3;
Point trajectoire[] = new Point[maxPoints];
int nextPoint = 1;

void setup() {
  size(800, 800);

  SA = new Point(200, 400, true);
  SB = new Point(600, 400, true);

  A = new Point(400, 100, false);
  D = new Point(400, 700, false);

  robot = new Robot(D.x, D.y);

  calculate();
}


// Permet de vérifier si 2 droites s'intersectent. J'ai pas réussi à implémenter la version dans le TD

boolean ccw(Point A, Point B, Point C) {
  return (C.y-A.y)*(B.x-A.x) > (B.y-A.y)*(C.x-A.x);
}
boolean intersect(Point A, Point B, Point C, Point D) {
  return ccw(A, C, D) != ccw(B, C, D) && ccw(A, B, C) != ccw(A, B, D);
}



void calculate() {

  float dist_d_sa_a = dist(D.x, D.y, SA.x, SA.y) + dist (SA.x, SA.y, A.x, A.y);
  float dist_d_sb_a = dist(D.x, D.y, SB.x, SB.y) + dist (SB.x, SB.y, A.x, A.y);


  if (!intersect(A, D, SA, SB)) {
    maxPoints = 2;
    trajectoire[0] = D;
    trajectoire[1] = A;
    return;
  }



  maxPoints = 3;
  if (dist_d_sa_a < dist_d_sb_a) {
    trajectoire[0] = D;
    trajectoire[1] = SA;
    trajectoire[2] = A;
  } else {
    trajectoire[0] = D;
    trajectoire[1] = SB;
    trajectoire[2] = A;
  }
}


void draw() {
  background(80);
  stroke(255);
  line(SA.x, SA.y, SB.x, SB.y);
  fill(255);

  A.show();
  D.show();
  SA.show();
  SB.show();

  stroke(200, 50, 50);
  for (int i = 0; i < maxPoints-1; i++) {
    line(trajectoire[i].x, trajectoire[i].y, trajectoire[i+1].x, trajectoire[i+1].y);
  }
  robot.show();
  if (!robot.rotate) {
    if (robot.move) { 
      robot.moveToPoint();
    }
  } else {
    robot.robotRotate();
  }
}

void keyPressed() {
  if (key == ' ') {
    if (nextPoint == maxPoints) {
      nextPoint = 0;
    }
    robot.move = true;
    robot.rotate = true;
    robot.rotateStart = true;
    if (nextPoint == maxPoints-2 && trajectoire[nextPoint].x > robot.pos.x) {
      println(trajectoire[nextPoint].x + " - ", robot.pos.x);
      robot.destination = new PVector(trajectoire[nextPoint].x+24, trajectoire[nextPoint].y);
    } else if (nextPoint == maxPoints-2 && trajectoire[nextPoint].x < robot.pos.x) {
      robot.destination = new PVector(trajectoire[nextPoint].x-24, trajectoire[nextPoint].y);
    } else {
      robot.destination = new PVector(trajectoire[nextPoint].x, trajectoire[nextPoint].y);
    }
    nextPoint +=1;
  }
}


void mouseClicked() {
  if (mouseButton == LEFT) {
    SA.x = mouseX;
    SA.y = mouseY;
  }
  if (mouseButton == RIGHT) {
    SB.x = mouseX;
    SB.y = mouseY;
  }
  calculate();
}
