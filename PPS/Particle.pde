class Particle {

  
  
  
  int id, particleWidth;
  PVector location, angle;
  color particleColor = color(50, 200, 50);

  int leftCount, rightCount;

  float deltaPhi = alpha;

  Particle(int tempId, PVector tempLocation, PVector tempAngle, int tempWidth) {

    id = tempId;
    location = tempLocation;
    angle = tempAngle;
    particleWidth = tempWidth;

    // Random Angle
    // angle.rotate(random(0,2*PI));
  }


  void drawParticle() {


    fill(particleColor);
    noStroke();
    circle(location.x, location.y, particleWidth);


    stroke(0);
    int lineLength = 1;
    line(location.x + angle.x*-lineLength*0, location.y + angle.y*-lineLength*0, location.x + angle.x*lineLength, location.y + angle.y*lineLength);
    /*
      if (id == 0){
     fill(50, 50, 200, 30);
     circle(location.x, location.y, detectionCircleWidth);
     
     lineLength = 100;
     line(location.x + angle.x*-lineLength*0, location.y + angle.y*-lineLength*0, location.x + angle.x*lineLength, location.y + angle.y*lineLength);
     
     
     
     textSize(16);
     fill(255,0,0);
     text(leftCount, location.x-25, location.y-10); 
     fill(0,0,255);
     text(rightCount, location.x+15, location.y-10); 
     }
     
     
     
     */
    //fill(0,0,0,0);
    //square(location.x-espacement/2,location.y-espacement/2,espacement);
  }

  void checkNeighboor() {
    float degreeAngle = PVector.angleBetween(angle, new PVector(1, 0));
    float checkAngle = PVector.angleBetween(angle, new PVector(0, -1));
    if (checkAngle > PI/2) {
      degreeAngle = PVector.angleBetween(angle, new PVector(-1, 0)) + PI;
    }

    //println("Degree: ", degreeAngle);

    //if (id == 0){
    //float lineEquationMouse = -sin(-degreeAngle)*(mouseX - location.x)+cos(-degreeAngle)*(mouseY-location.y);
    //println(lineEquationMouse);
    //}
    rightCount = 0;
    leftCount = 0;
    int totalCount;
    int totalCountColor = 0;
    int sign ;

    for (int i = 0; i<particleNumber; i++) {
      //println(dist(location.x, location.y, particles[i].location.x, particles[i].location.y));
      if (dist(location.x, location.y, particles[i].location.x, particles[i].location.y) < (detectionCircleWidth/2)) {


        if (i != id) {

          float lineEquation = -sin(-degreeAngle)*(particles[i].location.x - location.x)+cos(-degreeAngle)*(particles[i].location.y-location.y);

          if (lineEquation > 0) {

            //particles[i].particleColor = color(200, 50, 50);
            rightCount++;
          } else {
            //particles[i].particleColor = color(50, 50, 200);
            leftCount++;
          }
        }
      }
      if (dist(location.x, location.y, particles[i].location.x, particles[i].location.y) < (detectionCircleWidth/2)) {
       if (i != id) {
         totalCountColor++;
         
       }
      
      
      }
      
      
      
    }

    totalCount = leftCount + rightCount;
    
    sign = 1;
    if (rightCount - leftCount < 0) {
      sign = -1;
    }

    // Count neighboor but with detection radius of 1.3 (for colors)





    if (15 < totalCount && totalCount <= 35) {
      particleColor = color(100, 205, 255); // Blue
    } else if (totalCount > 35) {
      particleColor = color(255, 100, 100); // Yellow
    } else if (13 <= totalCount && totalCount <=15) {
      particleColor = color(152, 102, 48); // Brown
    } else if (totalCountColor > 15) {
      particleColor = color(209, 65, 192); // Magenta
    } else {
      particleColor = color(50, 200, 50); // Green
    }


    deltaPhi = alpha + (beta * totalCount * sign);
    // println(alpha," - ", beta, " - ", totalCount, " - ",sign, " - ", deltaPhi);
  }



void moveParticle() {

  if (location.x < 0) {
    location.x = width;
  } else if (location.x > width) {
    location.x = 0;
  }

  if (location.y < 0) {
    location.y = height;
  } else if (location.y > height) {
    location.y = 0;
  }


  angle.rotate(radians(deltaPhi));
  location.add(angle.copy().mult(velocity));
}
}
