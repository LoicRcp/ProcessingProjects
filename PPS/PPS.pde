
int cameraX = 0;
int cameraY =0;


int particleMax = 50000;
int particleNumber = 300; //2230 limit  - 2240 startNumber
int particleWidth = 16;
float velocity = 0.67;
int alpha = 180;
int beta = 17; 
int detectionCircleWidth = 5*particleWidth;


//float espacement = 40;
int framerate = 30;

Particle[] particles;
particleSystem ps;


void setup() {
  size(400, 400);
  background(0);
  frameRate(framerate);
  ps = new particleSystem();
}


void draw() {

  background(0); 
  ps.display();
}



void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      cameraY += 10;
    }
    if (keyCode == LEFT) {
      cameraX += 10;
    }
    if (keyCode == RIGHT) {
      cameraX -= 10;
    }
    if (keyCode == DOWN) {
      cameraY -= 10;
    }
  }
  if (key == ' ') {
    cameraX = width/2;
    cameraY = height/2;
  }
}
