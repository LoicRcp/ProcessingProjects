float incrementeValue = 0.1;
int scale = 20;
int cols, rows;

float zoff;
int particleNb = 20000;
float vectorMagnitude = 5;
float zoffIncr = 0.1;
float pSpeed = 10;
float bgSpeed = 0.05;
float pBrightness = 12;



Particle[] particles = new Particle[particleNb];;


PVector[] flowfield;

void setup() {
  size(800, 800, P2D);
  frameRate(120);
   cols = floor(width/scale);
   rows = floor(height/scale);
   zoff=0;
   
   flowfield = new PVector[cols * rows];
   
   for (int i = 0; i< particleNb;i++){
     particles[i] = new Particle();
   }
     background(0);
}



void draw() {

  float xoff = 0;
  for (int x = 0; x < cols; x++) {
    float yoff = 0;
    for (int y = 0; y < rows; y++) {
      //println(x,"-",y);
      float angle=noise(xoff,yoff,zoff)*TWO_PI*4;
      int index = (x+y * cols); 
      
      PVector vector = PVector.fromAngle(angle);
      vector.setMag(vectorMagnitude);
      flowfield[index] = vector;
      //println(flowfield[index]);
      
    /*      
      stroke(0,50);
      push();
      strokeWeight(1);
      translate(x*scale,y*scale);
      rotate(vector.heading());
      line(0,0,scale,0);
      pop();
      */
      yoff+=incrementeValue;
      //fill(noiseColor);
      //rect(x*scale, y*scale, scale, scale);
    }
    xoff+=incrementeValue;
    
    zoff+=zoffIncr;
  }
     for (int i = 0; i< particleNb;i++){
     particles[i].follow(flowfield);

     /*
    float frictionCoef = 0.5;
    float normalForce = 1;
    float frictionMag = frictionCoef*normalForce;
    PVector friction = particles[i].vel.copy();
    friction.normalize();
    friction.mult(-1);
    friction.mult(frictionMag);
     particles[i].applyForce(friction);
     
     */
     
       particles[i].update();
     particles[i].bords();
     particles[i].show();
     
   }
  
  loadPixels();
  for(int i = 0; i < pixels.length;i++){
    
    pixels[i] = color(  lerpColor(pixels[i],0,bgSpeed ));
    //if (pixels[i] < 0){ pixels[i] = color(0);}
    
  }
  updatePixels();
}
