class Particle { //<>//



  PVector pos, vel, acc;
  float maxSpeed;
  PVector prevPos;
  Particle() {
    pos = new PVector(random(width), random(height));
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    maxSpeed = pSpeed;

    prevPos = pos.copy();
  }


  void update() {
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.mult(0);
  }

  void applyForce(PVector force) {
    acc.add(force);
  } 


  void show() {
    stroke(255, pBrightness);
    strokeWeight(1);
    line(pos.x, pos.y, prevPos.x, prevPos.y);
    updatePrev();
    //point(pos.x,pos.y);
  }

  void updatePrev() {
    prevPos.x = pos.x;
    prevPos.y = pos.y;
  }


  void bords() {
    if ( pos.x >width) { 
      pos.x =0;
      updatePrev();
    }
    if ( pos.x <0) { 
      pos.x =width;
      updatePrev();
    }

    if ( pos.y >height) { 
      pos.y =0;
      updatePrev();
    }
    if ( pos.y <0) { 
      pos.y =height;
      updatePrev();
    }
  }




  void follow(PVector[] flowfield) {
    int x = floor(pos.x /scale);
    int y = floor(pos.y /scale);

    if (y >=height/scale) {
      y=height/scale-1;
    }
    if (x >=width/scale) {
      x=width/scale-1;
    }

    int index = x+y *cols;
    //println(x,'-',y,'-',index);

    PVector force = flowfield[index];
    applyForce(force);
  }
}
