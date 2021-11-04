class Ant {

  PVector pos;
  PVector velocity;
  PVector desiredDirection;

  float maxSpeed = 2;
  float steerStrenght = 2;
  float wanderStrength = 0.15;

  float detectionRadius = 25;


  float angle;
  PVector angleVector;
  int colonyNb;
  int antNb;

  int time = millis();
  
  
  
  Ant(PVector _pos, float _angle, int _colonyNb, int _antNb) {

    pos = _pos;
    angle = _angle;
    colonyNb = _colonyNb;
    antNb = _antNb;
    
  }

  Ant(PVector _pos, int _colonyNb, int _antNb) {

    angle = random(0, 360);
    angleVector = new PVector(1, 0).rotate(angle);

    pos = _pos;
    velocity = new PVector(1, 0).rotate(angle);
    desiredDirection = velocity.copy();



    colonyNb = _colonyNb;
    antNb = _antNb;
  }


  Ant(int _colonyNb, int _antNb) {
    colonyNb = _colonyNb;

    pos = new PVector(colonyList[colonyNb].pos.x, colonyList[colonyNb].pos.y);
    velocity = new PVector(1, 0).rotate(angle);
    desiredDirection = velocity.copy();

    angle = random(0, 360);
    angleVector = new PVector(1, 0).rotate(angle);

    antNb = _antNb;
  }



  void dropMarkers() {
    if (dist(pos.x, pos.y, colonyList[colonyNb].pos.x, (colonyList[colonyNb].pos.y)) < (colonyList[colonyNb].colonyRadius)) {
    }
  }


  void updateMovement() {


    desiredDirection = desiredDirection.add(new PVector(random(-1, 1), random(-1, 1)).mult(wanderStrength)).normalize();
    //desiredDirection = (new PVector(mouseX,mouseY).sub(pos)).normalize();


    PVector desiredVelocity = desiredDirection.copy().mult(maxSpeed);
    PVector desiredSteeringForce = desiredVelocity.sub(velocity).mult(steerStrenght);
    PVector acceleration = (desiredSteeringForce.limit(steerStrenght)).div(1);

    velocity = velocity.add(acceleration).limit(maxSpeed);
    pos.add(velocity);


    angle = velocity.heading();
    //angle = atan2(velocity.y, velocity.x);    


    if (antNb == 0) {
    }

    if (pos.x < 0) {
      pos.x = width;
    } else if (pos.x > width) {
      pos.x = 0;
    }

    if (pos.y < 0) {
      pos.y = height;
    } else if (pos.y > height) {
      pos.y = 0;
    }
  }



  void dropPheromon() {
    if (millis() > time + 100){
     
      pheromonGrid[(int)pos.x][(int)pos.y] = new pheromon(pos.copy(), "red");
      
      
      time = millis();
    }
    
    
    
    
  }

  void display() {
    fill(255);


    push();
    translate(pos.x, pos.y);
    fill(255, 0, 0);

    rotate(angle + PI/2);
    image(sprite, 0-4, 0-8);


    //if (antNb == 0){
    //  fill(255,0,0);
    //circle(0,0,6);
    //}

    pop();
  }
}
