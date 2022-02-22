float r1 = baseColor;
float g1 = baseColor;
float b1 = baseColor;



class grid {
  float x, y, s;

  float localR2 =baseColor;
  float localG2 = baseColor;
  float localB2 = baseColor;
  int number;

  grid(float tempX, float tempY, float tempS, int tempNumber) {
    x = tempX;
    y = tempY;
    s = tempS;
    number = tempNumber;
  }

  void display() {


   if (grille == false) {
    noStroke();}
   else if (grille == true) {
    stroke(0);}
    fill(localR2, localG2, localB2);
    square(x, y, s);
    textAlign(CENTER);
    textSize(10);
    fill(0);
    //text(number, x+s/2,y+s/2);
  }

  void update() {
    localR2 = lerp(localR2, r1, 0.1);
    localG2 = lerp(localG2, g1, 0.1);
    localB2 = lerp(localB2, b1, 0.1);
    
  }
  

  void mouseClick(float tempX, float tempY) {
    float distance = dist(tempX, tempY, x+(s/2), y+(s/2));
    distance = distance/tailleLight;


    float localtestG2 = g2;

    if ((localtestG2 - distance) > baseColor) {




      localR2 += -57 - distance;
      localG2 += 114 - distance;
      localB2 += -5 - distance;    







      if (localR2 < baseColor) { 

        localR2 = baseColor;
      }
      if (localG2 < baseColor) { 

        localG2 = baseColor;
      }
      if (localB2 < baseColor) { 

        localB2 = baseColor;
      }
    }
  }
  }
