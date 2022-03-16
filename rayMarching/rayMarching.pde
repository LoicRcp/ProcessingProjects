 //<>//

explorer exp;

boxObstacle box1;
circleObstacle circle1;
boxObstacle box2;
circleObstacle circle2;
boxObstacle box3;
circleObstacle circle3;

ArrayList<obstacle> obstacles;
float angle;
PVector angleVector;

ArrayList<PVector> posArray = new ArrayList<PVector>();

void setup() {
  size(800, 800);
  frameRate(9999);
  angle = 0.008;
  angleVector = new PVector(0, 1);

  obstacles = new ArrayList<obstacle>();

  exp = new explorer();

  box1 = new boxObstacle(new PVector(400, 300), 60, 60);
  circle1 = new circleObstacle(new PVector(600, 600), 64);

  box2 = new boxObstacle(new PVector(100, 600), 30, 30);
  circle2 = new circleObstacle(new PVector(500, 50), 48);

  box3 = new boxObstacle(new PVector(600, 200), 45, 45);
  circle3 = new circleObstacle(new PVector(350, 150), 32);

  obstacles.add(box1);
  obstacles.add(circle1);
  obstacles.add(box2);
  obstacles.add(circle2);
  obstacles.add(box3);
  obstacles.add(circle3);
}



float getMinVal(PVector pos) {

  float minVal = 999999;
  for (obstacle ob : obstacles) {
    //ob.show();
    float dist = ob.distance(pos);
    if (dist < minVal) {
      minVal = dist;
    }
  }
  return minVal;
}


void drawRayCircle(PVector pos, float radius) {
  stroke(255);
  fill(200, 50);
  circle(pos.x, pos.y, radius*2);
}

void draw() {


  float minVal = 9999;

  background(30);
  exp.move();
  exp.show();


  PVector pos = exp.pos.copy();
  PVector nextPos = new PVector(0, 0); 
  int counter = 0;
  
  
  while (minVal > 10 && counter < 20) {
    //for (int i=0; i < 4; i++){
    minVal = getMinVal(pos); 

    if (minVal < 800) {
      //drawRayCircle(pos, minVal); 
      angleVector = angleVector.rotate(angle);
      nextPos.x = pos.x + angleVector.x * minVal;
      nextPos.y = pos.y + angleVector.y * minVal;
      //line(pos.x, pos.y, nextPos.x, nextPos.y);
      
      pos = nextPos.copy();
    }
    noStroke();
    
    if (minVal<10){
      posArray.add(nextPos);
    }
    
    for (int i = 0; i < posArray.size(); i++) {

        
      circle(posArray.get(i).x, posArray.get(i).y,2);
    }
    
    counter+=1;
  }




}
