

// CONSEILS DE MME LUCET POUR FIX MA SIM

// Lors du choix de direction, ne pas se baser UNIQUEMENT sur le nombre de phéromone, mais aussi sur la puissance du phéromone. 10 phéromone à 0.1 de puissance = 1 phéromone a 1 de puissance.
// Calculer le total de taux phéromonal dans chaque zone (pour chaque phéromone présent, 1*puissance du phéromone (compris entre 0 et 1))
// prendre le tauxc phéromonal de chaque zone, puis mettre tout entre 0 et 1.


// Exemple
//______________________________________
//|   0.15 |      0.70        |   0.15 |
// _____________________________________

// Puis générer un nombre aléatoire entre 0 et 1, et en fonction de ou ça tombe, tourner à l'endroit indiquer.





class Ant {

  PVector pos;
  PVector velocity;
  PVector desiredDirection;

  float maxSpeed = 2;
  float steerStrenght = 2;
  float wanderStrength = 0.25;

  float detectionRadius = 40;


  float angle;
  PVector angleVector;
  int colonyNb;
  int antNb;

  boolean hasFood = true;

  int time =  millis();

  int viewDistance = 30;
  int researchSquareWitdh = 15;

  Ant(PVector _pos, float _angle, int _colonyNb, int _antNb) {

    pos = _pos;
    angle = _angle;
    colonyNb = _colonyNb;
    antNb = _antNb;
    hasFood  = false;
  }

  Ant(PVector _pos, int _colonyNb, int _antNb) {

    angle = random(0, 360);
    angleVector = new PVector(1, 0).rotate(angle);

    pos = _pos;
    velocity = new PVector(1, 0).rotate(angle);
    desiredDirection = velocity.copy();
    hasFood  = false;



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
    hasFood  = false;
  }





  void updateMovement() {


    //desiredDirection = angleVector;



    //desiredDirection = desiredDirection.add(new PVector(random(-1, 1), random(-1, 1)).mult(wanderStrength)).normalize();
    desiredDirection = velocity.add(checkPheromon(velocity, angleVector));


    //desiredDirection = (new PVector(mouseX,mouseY).sub(pos)).normalize();


    PVector desiredVelocity = desiredDirection.copy().mult(maxSpeed);
    PVector desiredSteeringForce = desiredVelocity.sub(velocity).mult(steerStrenght);
    PVector acceleration = (desiredSteeringForce.limit(steerStrenght)).div(1);

    velocity = velocity.add(acceleration).limit(maxSpeed);




    pos.add(velocity);

    /*
    stroke(255, 0, 0);
     line(pos.x, pos.y, pos.x + velocity.copy().setMag(50).x, pos.y + velocity.copy().setMag(50).y);
     */
    angle = velocity.heading();
    angleVector = new PVector(1, 0).rotate(angle);

    //if (!hasFood){
      checkFood(velocity);
    //}
    //angle = atan2(velocity.y, velocity.x);    

    if (hasFood) checkBase();


    if (pos.x < 0+35) {
      pos.x = width-35;
    } else if (pos.x > width-35) {
      pos.x = 0+35;
    }

    if (pos.y < 0+35) {
      pos.y = height-35;
    } else if (pos.y > height-35) {
      pos.y = 0+35;
    }
  }

  void checkBase() {
    if (dist(pos.x, pos.y, colonyList[colonyNb].pos.x, colonyList[colonyNb].pos.y) < colonyList[colonyNb].colonyRadius/2) {
      hasFood = false;
      velocity.rotate(PI);
    }
  }

  void checkFood(PVector velocity) {

    PVector middle = new PVector(pos.x + velocity.copy().setMag(10).x, pos.y + velocity.copy().setMag(10).y);

    for (float i = middle.x-5; i < middle.x+5; i++) {
      for (float j = middle.y-5; j < middle.y+5; j++) {
        try {
          if (foodGrid[(int)i][(int)j] != null) {
            hasFood = true;
            velocity.rotate(PI);
            foodGrid[(int)i][(int)j].quantity--;
            return;
          }
        }
        catch(Exception e) {
        }
      }
    }
  }

  void dropPheromon() {
    if (millis() > time + 100) {
      String pheromonType = "";
      if (hasFood) {
        pheromonType = "toFood";
      } else {
        pheromonType = "toBase";
      }
      pheromonGrid[(int)pos.x][(int)pos.y] = new pheromon(pos.copy(), pheromonType);


      time = millis();
    }
  }


  PVector checkPheromon(PVector velocity, PVector angleVector) {



    PVector left = new PVector(pos.x + velocity.copy().rotate(-QUARTER_PI - (QUARTER_PI/2)).copy().setMag(viewDistance).x, pos.y + velocity.copy().rotate(-QUARTER_PI - (QUARTER_PI/2)).copy().setMag(viewDistance).y);
    PVector middle = new PVector(pos.x + velocity.copy().setMag(viewDistance).x, pos.y + velocity.copy().setMag(viewDistance).y);
    PVector right = new PVector(pos.x + velocity.copy().rotate(QUARTER_PI + (QUARTER_PI/2)).copy().setMag(viewDistance).x, pos.y + velocity.copy().rotate(QUARTER_PI + (QUARTER_PI/2) ).copy().setMag(viewDistance).y);

    float leftPherRate = 0;
    float middlePherRate = 0;
    float rightPherRate = 0;


    //rect(left.x, left.y, researchSquareWitdh, researchSquareWitdh);

    for (float i = left.x-researchSquareWitdh; i < left.x+researchSquareWitdh; i++) {
      for (float j = left.y-researchSquareWitdh; j < left.y+researchSquareWitdh; j++) {
        // square(i,j,1);

        try {
          if (pheromonGrid[(int)i][(int)j] != null) {
            if ((!hasFood && pheromonGrid[(int)i][(int)j].type == "toFood") || (hasFood && pheromonGrid[(int)i][(int)j].type == "toBase")) {
              leftPherRate+= pheromonGrid[(int)i][(int)j].strenght;
            }
          }
          if (foodGrid[(int)i][(int)j] != null) {
            leftPherRate+= 10000; //<>//
          }
        }



        catch(Exception e) {
        }
      }
    }

    for (float i = middle.x-researchSquareWitdh; i < middle.x+researchSquareWitdh; i++) {
      for (float j = middle.y-researchSquareWitdh; j < middle.y+researchSquareWitdh; j++) {
        // square(i,j,1);
        try {
          if (pheromonGrid[(int)i][(int)j] != null) {
            if ((!hasFood && pheromonGrid[(int)i][(int)j].type == "toFood") || (hasFood && pheromonGrid[(int)i][(int)j].type == "toBase")) {
              middlePherRate+= pheromonGrid[(int)i][(int)j].strenght;
            }
          }
          if (foodGrid[(int)i][(int)j] != null) {
            middlePherRate+= 10000;
          }
        }
        catch(Exception e) {
        }
      }
    }

    for (float i = right.x-researchSquareWitdh; i < right.x+researchSquareWitdh; i++) {
      for (float j = right.y-researchSquareWitdh; j < right.y+researchSquareWitdh; j++) {
        // square(i,j,1);
        try {
          if (pheromonGrid[(int)i][(int)j] != null) {
            if ((!hasFood && pheromonGrid[(int)i][(int)j].type == "toFood") || (hasFood && pheromonGrid[(int)i][(int)j].type == "toBase")) {
              rightPherRate+= pheromonGrid[(int)i][(int)j].strenght;
            }
          }
          if (foodGrid[(int)i][(int)j] != null) {
            rightPherRate+= 10000;
          }
        }
        catch(Exception e) {
        }
      }
    }


    float totalPherRate = leftPherRate + middlePherRate +rightPherRate;

    leftPherRate = leftPherRate / totalPherRate;
    middlePherRate = middlePherRate / totalPherRate;
    rightPherRate = rightPherRate / totalPherRate;







    // find greater number
    String greater;

    if (totalPherRate != 0) {
      float randomValue = random(0, 1);
      if (0 < randomValue && randomValue <= leftPherRate ) {
        desiredDirection = angleVector.copy().rotate(-QUARTER_PI - (QUARTER_PI/2)).normalize();
      } else if (leftPherRate < randomValue && randomValue <= leftPherRate+middlePherRate) {
        desiredDirection = angleVector.copy().normalize();
      } else if (leftPherRate+middlePherRate < randomValue && randomValue <= 1) {
        desiredDirection = angleVector.copy().rotate(QUARTER_PI + (QUARTER_PI/2)).normalize();
      }
    } else {
      desiredDirection = velocity.copy().rotate(random(-wanderStrength, wanderStrength) * PI).normalize();
    }



    /*
    if ((leftPherRate + middlePherRate + rightPherRate) != 0) {
     if (middlePherRate > leftPherRate) {
     if (middlePherRate > rightPherRate) {
     greater = "mid";
     desiredDirection = angleVector.copy().normalize();
     } else {
     greater = "right";
     desiredDirection = angleVector.copy().rotate(QUARTER_PI + (QUARTER_PI/2)).normalize();
     }
     } else {
     if (leftPherRate > rightPherRate) {
     greater = "left";
     desiredDirection = angleVector.copy().rotate(-QUARTER_PI - (QUARTER_PI/2)).normalize();
     } else {
     greater = "right";
     desiredDirection = angleVector.copy().rotate(QUARTER_PI + (QUARTER_PI/2)).normalize();
     }
     }
     } else {
     //println("NO PHER - " + millis());
     desiredDirection = velocity.copy().rotate(random(-wanderStrength, wanderStrength) * PI).normalize();
     }
     */





    /*
    fill(50, 200, 50);
     
     rect(left.x-10, left.y-10, 20, 20);
     rect(middle.x-10, middle.y-10, 20, 20);
     rect(right.x-10, right.y-10, 20, 20);
     */
    return desiredDirection;
  }


  void display() {
    fill(255);



    push();
    translate(pos.x, pos.y);
    fill(255, 0, 0);

    rotate(angle + PI/2);
    if (hasFood) tint(50, 255, 50);
    image(sprite, 0-4, 0-8);




    //if (antNb == 0){
    //  fill(255,0,0);
    //circle(0,0,6);
    //}

    pop();
  }
}
