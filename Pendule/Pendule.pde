
float r = 250;
float theta = 0.5*PI;

float aVel = 0.0;
float aAcc = 0.0;

float gravity = 0.001;

void setup(){
 size(800,800);
 background(80);
 frameRate(120);
  
  
}


void draw(){

  translate(width/2,0);
 background(80); 
  
 float x = r * sin(theta);
 float y = r * cos(theta);
 stroke(255);
 line(0,0,x,y);
 circle(x,y,32);
  
 aAcc = gravity *sin(-theta); 
  
 
 theta += aVel;
 
 aVel += aAcc;
 
 aVel *= 0.999;

 

  
}
