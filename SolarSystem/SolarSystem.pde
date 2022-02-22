int bgStarNb = 500;
int[][] starBackground = new int[bgStarNb][3];


planet[] planets = new planet[8];

planet earth;
planet jupiter;
void setup() {

  size(1000, 1000);

  translate(width/2, height/2);
  for (int i=0; i < bgStarNb; i++) {
    starBackground[i][0] = (int)random(-width/2, width/2);
    starBackground[i][1] = (int)random(-width/2, width/2);
    starBackground[i][2] = (int)random(1, 2);
  }  


  // POS - Revolution En seconde - Taille - Couleur

  planets[0] = new planet(new PVector(50, 0), 88, 10, color(100, 100, 100)); // mercury
  planets[1] = new planet(new PVector(75, 0), 224, 13, color(240, 184, 44)); // venus
  planets[2] = new planet(new PVector(100, 0), 365, 16, color(100, 100, 255)); // earth
  planets[3] = new planet(new PVector(150, 0), 687, 13, color(206, 74, 37)); // mars
  planets[4] = new planet(new PVector(250, 0), 800, 32, color(201, 171, 162)); // jupiter
  planets[5] = new planet(new PVector(350, 0), 900, 28, color(149, 133, 128)); // saturn
  planets[6] = new planet(new PVector(420, 0), 1000, 24, color(101, 185, 185)); // uranus
  planets[7] = new planet(new PVector(470, 0), 1100, 22, color(101, 120, 185)); // neptune
}
void draw() {

  background(10);
  translate(width/2, height/2);
  fill(255);
  noStroke();

  for (int i=0; i < bgStarNb; i++) {
    circle(starBackground[i][0], starBackground[i][1], starBackground[i][2] );
  }
  fill(255, 255, 50);
  circle(0, 0, 64);


  for (planet plan : planets) {
    if (plan != null) {

      plan.showPlanet();
      plan.movePlanet();
    }
  }
}
