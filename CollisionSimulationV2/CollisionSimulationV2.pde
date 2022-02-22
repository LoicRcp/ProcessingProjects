int ballsNumber = 50; //<>//


Ball[] balls = new Ball[ballsNumber];





void setup() {
  size(600, 600);
  frameRate(60);
  background(80);

  /* 
   balls[0] = new Ball(0, new PVector(260, 300), color(random(60, 255), random(60, 255), random(60, 255), 200), 32);
   balls[0].acceleration = new PVector(1, 0);
   balls[1] = new Ball(0, new PVector(340, 300), color(random(60, 255), random(60, 255), random(60, 255), 200), 32);
   balls[1].acceleration = new PVector(0, 0);
   */

  int ballsCreated = 0;
  for (int i = 0; i<ballsNumber; i++) {
    boolean overlap = true;
    PVector location;
    float ballWidth;
    do {
      location = new PVector(width/2 + random(-300, 300), height/2 + random(-300, 300)); //réparti au hasard
      ballWidth = random(16, 64);

      overlap = false;
      for (int j = 0; j<ballsCreated; j++) {
        float distance = dist(location.x, location.y, balls[j].location.x, balls[j].location.y);
        if ( (distance < (ballWidth/2 + balls[j].ballWidth/2)) && (distance != 0)) {
          overlap = true;
        }
      }
    } while (overlap);
    //location = new PVector(width/2 + random(-200, 200), height/2); // Tout sur la meme ligne
    //location = new PVector(width/4, height/2 + random(-200, 200)); // tout sur la meme colonne
    color ballColor = color(random(20, 255), random(20, 255), random(20, 255), 255);



    balls[i] = new Ball(i, location, ballColor, ballWidth);
    ballsCreated +=1;
  }
}



void draw() {
  background(0);
  for (int i = 0; i<ballsNumber; i++) {
    balls[i].checkCollision = true;
  }


  // WIND
  PVector wind = new PVector(1, 0);

  for (int i = 0; i<ballsNumber; i++) {



    // GRAVITY
    float m = balls[i].mass;
    PVector gravity = new PVector(0, 0.01*m);

    // FRICTION
    float frictionCoef = 1;
    float normalForce = 1;
    float frictionMag = frictionCoef*normalForce;
    PVector friction = balls[i].velocity.copy();
    friction.normalize();
    friction.mult(-1);
    friction.mult(frictionMag);

    // APPLYING FORCES

    // balls[i].applyForce(wind);
    // balls[i].applyForce(gravity);
    balls[i].applyForce(friction);

    balls[i].drawBall();
    balls[i].moveBall();
    balls[i].bounceBall();



    balls[i].colliding = false;
    for (int j = 0; j<ballsNumber; j++) {


      checkCollision(balls[i], balls[j]);
      //println("ball: ",i," velocity ",balls[i].velocity);
    }
  }
}

void keyPressed() {
  if (key =='q') {
    PVector wind = new PVector(-1, 0);
    for (int i = 0; i<ballsNumber; i++) {
      balls[i].applyForce(wind);
    }
  }
}
void checkCollision(Ball ball1, Ball ball2) {
  boolean movingToward = false;

  // https://math.stackexchange.com/questions/1438002/determine-if-objects-are-moving-towards-each-other
  PVector relativeVel = ball2.velocity.copy().sub(ball1.velocity.copy());
  PVector relativeDisplacement =ball2.location.copy().sub(ball1.location.copy());
  if (relativeVel.copy().dot(relativeDisplacement.copy()) < 0) {
    movingToward = true;
  }


  float distance = dist(ball1.location.x, ball1.location.y, ball2.location.x, ball2.location.y);
  if  ((distance < ball1.ballWidth/2 + ball2.ballWidth/2) &&(distance != 0) && (movingToward == true)) {

    //println("CheckingCollision for ",ball1.id,ball2.id);

    // Color involved balls
    // ball1.ballTempColor = color(255, 0, 0, 255);
    // ball2.ballTempColor = color(255, 0, 0, 255);

    //println(ball1.id, " & ", ball2.id, " colliding");

    // ------------------------

    // Collisions maths

    //println("ball2.location.x:", ball2.location.x);
    //println("ball1.location.x:", ball1.location.x);
    //println("ball2.location.y:", ball2.location.y);
    //println("ball1.location.y:", ball1.location.y);



    PVector normalVector = new PVector(ball2.location.x - ball1.location.x, ball2.location.y - ball1.location.y);

    //println("normalVector:", normalVector);
    //println("normalVector.mag():", normalVector.mag());

    PVector unitVector = normalVector.div(normalVector.mag());

    //println("unitVector:", unitVector);

    PVector unitTangent = new PVector(-unitVector.y, unitVector.x);

    //println("unitTangent:", unitTangent);

    //println("ball1.velocity:", ball1.velocity);
    //println("ball2.velocity:", ball2.velocity);



    float v1Normal  =  unitVector.dot(ball1.velocity);
    float v1Tangent =  unitTangent.dot(ball1.velocity);
    float v2Normal  = unitVector.dot(ball2.velocity);
    float v2Tangent = unitTangent.dot(ball2.velocity);

    //println("v1Normal:", v1Normal);
    //println("v1Tangent:", v1Tangent);
    //println("v2Normal:", v2Normal);
    //println("v2Tangent:", v2Tangent);

    //println("######");
    float v1AfterCollisionVelocityScalar = (v1Normal * (ball1.mass - ball2.mass) + 2*ball2.mass*v2Normal)/(ball1.mass + ball2.mass);
    float v2AfterCollisionVelocityScalar = (v2Normal * (ball2.mass - ball1.mass) + 2*ball1.mass*v1Normal)/(ball1.mass + ball2.mass);

    //println("v1AfterCollisionVelocityScalar:",v1AfterCollisionVelocityScalar);
    //println("v2AfterCollisionVelocityScalar:",v2AfterCollisionVelocityScalar);

    PVector v1AfterCollisionVelocityVectorNormal = unitVector.copy().mult(v1AfterCollisionVelocityScalar);
    PVector v1AfterCollisionVelocityVectorTangent = unitTangent.copy().mult(v1Tangent);



    //println("v1AfterCollisionVelocityVectorNormal:",v1AfterCollisionVelocityVectorNormal);
    //println("v1AfterCollisionVelocityVectorTangent:",v1AfterCollisionVelocityVectorTangent);

    PVector v2AfterCollisionVelocityVectorNormal = unitVector.copy().mult(v2AfterCollisionVelocityScalar);
    PVector v2AfterCollisionVelocityVectorTangent = unitTangent.copy().mult(v2Tangent);


    //println("v2AfterCollisionVelocityVectorNormal:",v2AfterCollisionVelocityVectorNormal);
    //println("v2AfterCollisionVelocityVectorTangent:",v2AfterCollisionVelocityVectorTangent);



    PVector v1AfterCollisionVelocity = v1AfterCollisionVelocityVectorNormal.add(v1AfterCollisionVelocityVectorTangent);
    PVector v2AfterCollisionVelocity = v2AfterCollisionVelocityVectorNormal.add(v2AfterCollisionVelocityVectorTangent);


    //println(" ball1.velocity:", ball1.velocity);
    //println("ball2.velocity:",ball2.velocity);

    //println("v1AfterCollisionVelocity:",v1AfterCollisionVelocity);
    //println("v2AfterCollisionVelocity:",v2AfterCollisionVelocity);

    ball1.velocity = v1AfterCollisionVelocity;
    ball2.velocity = v2AfterCollisionVelocity;

    ball1.location.add(ball1.velocity.copy().mult(1));
    ball2.location.add(ball2.velocity.copy().mult(1));





    //println("-----------------");
  }
}
