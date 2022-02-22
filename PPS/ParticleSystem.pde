class particleSystem{


float espacement;

int newParticle = particleNumber;

int time;






float x;
 float y;
particleSystem(){
  particles = new Particle[particleMax];

  espacement = sqrt((width*height)/particleNumber);

  /*
 particles[0] = new Particle(0, new PVector(400,400), new PVector(particleWidth/2,0), particleWidth);
   
   particles[1] = new Particle(1, new PVector(300,400), new PVector(particleWidth/2,0), particleWidth);
   particles[2] = new Particle(2, new PVector(500,400), new PVector(particleWidth/2,0), particleWidth);
   
   particles[3] = new Particle(3, new PVector(350,350), new PVector(particleWidth/2,0), particleWidth);
   particles[4] = new Particle(4, new PVector(450,350), new PVector(particleWidth/2,0), particleWidth);
   
   particles[5] = new Particle(5, new PVector(350,450), new PVector(particleWidth/2,0), particleWidth);
   particles[6] = new Particle(6, new PVector(450,450), new PVector(particleWidth/2,0), particleWidth);
   */


   x = particleWidth/2;
   y = particleWidth/2;
  for (int j = 0; j<particleNumber; j++) {

    x += espacement;
    if (x >= width+particleWidth/2) {
      y+=espacement;
      if (y%(espacement*2) ==0) {
        x = particleWidth/2 + espacement/2;
      } else {
        x = particleWidth/2;
      }
    }

    //println(j, new PVector(x,y));
    particles[j] = new Particle(j, new PVector(x, y), new PVector(particleWidth/2, 0).rotate(random(0, 360)), particleWidth);
  }

  time = millis();
}


void display(){
  textSize(32);
  fill(255);
  text(particleNumber,10,30);
  
  translate(cameraX,cameraY);
  
  stroke(255);
  fill(0,0,0,0);
  rect(0,0,width,height);
  
  
  




  for (int i = 0; i<particleNumber; i++) {
    particles[i].drawParticle();   
    particles[i].moveParticle();
    particles[i].checkNeighboor();
  }
  //saveFrame("/MovieMaker/image######.png");

  //println(mousePressed);


  if (mousePressed == true && millis() > time+50) {

    particles[particleNumber] = new Particle(particleNumber, new PVector(mouseX-cameraX, mouseY-cameraY), new PVector(particleWidth/2, 0).rotate(random(0, 360)), particleWidth);
    particleNumber +=1;
    time = millis();
  }
  
}



}
