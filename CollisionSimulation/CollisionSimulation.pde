int ballsNumber = 300;


Ball[] balls = new Ball[ballsNumber];





void setup(){
 size(600,600);
 frameRate(120);
 background(80);
 for (int i = 0; i<ballsNumber; i++){
    PVector location = new PVector(width/2 + random(-200, 200), height/2 + random(-200, 200)); //réparti au hasard
    //location = new PVector(width/2 + random(-200, 200), height/2); // Tout sur la meme ligne
    //location = new PVector(width/4, height/2 + random(-200, 200)); // tout sur la meme colonne
    color ballColor = color(random(60, 255), random(60, 255), random(60, 255), 200);
    float ballWidth = random(16,32);

   
   balls[i] = new Ball(i, location, ballColor, ballWidth);
   
 }
  
  
  
}



void draw(){
   background(80);

 for (int i = 0; i<ballsNumber; i++){
   PVector wind = new PVector(0.01,0);
   
   float m = balls[i].mass;
   PVector gravity = new PVector(0,0.01*m);
   
   
   float frictionCoef = 0.06;
   float normalForce = 1;
   float frictionMag = frictionCoef*normalForce;
   
   PVector friction = balls[i].velocity.copy();
   friction.normalize();
   friction.mult(-1);
   
   friction.mult(frictionMag);
   
   
   balls[i].applyForce(wind);

   balls[i].applyForce(gravity);
   balls[i].applyForce(friction);
   
   balls[i].drawBall();
   balls[i].moveBall();
   balls[i].bounceBall();
   
 }
  
  
  
}

void keyPressed(){
  if (key =='q'){
    PVector wind = new PVector(-1,0);
    for (int i = 0; i<ballsNumber; i++){
     balls[i].applyForce(wind); 
    }
    
    
  }
  
}
