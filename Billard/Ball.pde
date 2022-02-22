class Ball {

  float ballWidth;
  float mass;

  PVector location;
  PVector velocity;
  PVector acceleration;

  Ball(PVector tempLocation, float tempBallWidth) {

    location = tempLocation;

    ballWidth = tempBallWidth;
    mass = 3.14*((ballWidth/2)*(ballWidth/2)); // masse en fonction de l'aire de la balle

    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  void applyForce(PVector force) {
    PVector f = force.copy(); // On fait une copie car c'est par défaut passé par adresse.
    f.div(mass);
    acceleration.add(f);
  }


  void drawBall() { // afficher la balle
    fill(255);    
    circle(location.x, location.y, ballWidth);
    noStroke();
  }


  void moveBall() { // Déplacer la balle
    velocity.add(acceleration); // On ajoute a la vitesse de la balle, l'accéleration
    location.add(velocity); // On ajoute a la position de la balle, sa vitesse
    acceleration.mult(0); // On réinitialise l'accélération pour pas qu'elle s'accumule. Quand les forces s'arrête, l'accélération s'arrête.
  }

  void bounceBall() { // Collision au bord de la balle
    if (location.x > width-ballWidth/2) {
      velocity.x = abs(velocity.x) * -1;
      location.x = width-ballWidth/2;
    } else if (location.x < ballWidth/2) {
      velocity.x = abs(velocity.x);
      location.x = ballWidth/2;
    } else if (location.y > height-ballWidth/2) {
      velocity.y = abs(velocity.y) * -1;
      location.y =  height - ballWidth/2;
    } else if (location.y < ballWidth/2) {
      velocity.y = abs(velocity.y);
      location.y =  ballWidth/2;
    }
  }
}
