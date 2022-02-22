class Ball {

  float ballWidth;
  int id;
  color ballTempColor;
  color ballStaticColor;
  float mass;

  PVector location;
  PVector velocity;
  PVector acceleration;

  boolean colliding;
  boolean checkCollision;


  Ball(int tempId, PVector tempLocation, color tempBallColor, float tempBallWidth) {

    id = tempId;
    location = tempLocation;
    
    ballStaticColor = tempBallColor;
    ballTempColor = ballStaticColor;
    ballWidth = tempBallWidth;
    mass = 3.14*((ballWidth/2)*(ballWidth/2));
    //mass = 0.1;
    velocity = new PVector(0, 0);
    acceleration = new PVector(random(-1,1), random(-1,1));
    //acceleration = new PVector(0, 0);
    
  }



  void applyForce(PVector force) {
    PVector f = force.copy(); // On fait une copie car c'est par défaut passé par adresse.
    f.div(mass);
    acceleration.add(f);
  }


  void drawBall() { // afficher la balle
    //if (colliding){ballTempColor = color(255,0,0,255);}
    //else{ballTempColor = ballStaticColor;}
    fill(ballTempColor);
    PVector mouse = new PVector(mouseX, mouseY);
    PVector center = new PVector(width/2, height/2);
    //ballWidth = 1/(PVector.sub(center,location).mag()/500);
    //if (ballWidth > 32){ballWidth = 32;}
    circle(location.x, location.y, ballWidth);
    noStroke();
  }


  void moveBall() { // Déplacer la balle
  //  PVector mouse = new PVector(mouseX, mouseY); //La balle se dirige vers la souris
//    PVector dir = PVector.sub(mouse, location);

    //PVector center = new PVector(width/2, height/2); // La basse se dirige vers le centre
    //PVector dir = PVector.sub(center, location);


    //dir.normalize();
    //dir.mult(0.008);



    //acceleration = dir;



    velocity.add(acceleration); // On ajoute a la vitesse de la balle, l'accéleration
    //velocity.limit(1000);
    location.add(velocity); // On ajoute a la position de la balle, sa vitesse
    acceleration.mult(0); // On réinitialise l'accélération pour pas qu'elle s'accumule. Quand les forces s'arrête, l'accélération s'arrête.
  }

  void bounceBall() { // Collision au bord de la balle
    if (location.x > width-ballWidth/2) {
      // ballX = ballX - ballSpeedX;
      velocity.x = abs(velocity.x) * -1;
      location.x = width-ballWidth/2;

      //location.add(velocity);
  } else if (location.x < ballWidth/2) {
      velocity.x = abs(velocity.x);
      location.x = ballWidth/2;

      //location.add(velocity);
    } else if (location.y > height-ballWidth/2) {
      //ballY = ballY - ballSpeedY;
      velocity.y = abs(velocity.y) * -1;
      location.y =  height - ballWidth/2;

      //location.add(velocity);
    } else if (location.y < ballWidth/2) {
      velocity.y = abs(velocity.y);
      location.y =  ballWidth/2;

      //location.add(velocity);
    }
  }

  
  /*
    void bounceBall() { // Collision au centre de la basse
    if (location.x > width) {
      // ballX = ballX - ballSpeedX;
      velocity.x = velocity.x * -1;
      location.x = width;
      //location.add(velocity);
  } else if (location.x < 0) {
      velocity.x = velocity.x *-1;
      location.x = 0;
      //location.add(velocity);
    } else if (location.y > height) {
      //ballY = ballY - ballSpeedY;
      velocity.y = velocity.y * -1;
      location.y = location.y = height;
      //location.add(velocity);
    } else if (location.y < 0) {
      velocity.y = velocity.y *-1;
      location.y = location.y = 0;
      //location.add(velocity);
    }
  }
  */
  
    
  }
  
