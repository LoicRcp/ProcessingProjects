import peasy.*;

int dimension =128;
PeasyCam cam;
int maxIteration = 10;






ArrayList<MandelPoint> mandelBulb = new ArrayList<MandelPoint>();


class MandelPoint {
  PVector v;
  float i;

  MandelPoint(PVector v, float i) {
    this.v = v;
    this.i = i;
  }
}


void setup() {
  size(800, 800, P3D);

  cam = new PeasyCam(this, 500);
  
  
  
  
  for (int i=0; i < dimension; i++) {
    for (int j=0; j < dimension; j++) {
      boolean edge = false;
      int lastIteration = 0;
      for (int k=0; k < dimension; k++) {

        

        float x = map(i, 0, dimension, -1, 1);
        float y = map(j, 0, dimension, -1, 1);
        float z = map(k, 0, dimension, -1, 1);
        

        
        PVector zeta = new PVector(0,0,0);  
        
        int n = 8;
        
        int iteration = 0;
        
        while (true){
          
          
          spherical sphereZeta = sphere(zeta.x,zeta.y,zeta.z);
          float newx = pow(sphereZeta.r,n) * sin(sphereZeta.theta*n) * cos(sphereZeta.phi*n);
          float newy = pow(sphereZeta.r,n) * sin(sphereZeta.theta*n) * sin(sphereZeta.phi*n);
          float newz = pow(sphereZeta.r,n) * cos(sphereZeta.theta*n);
          
          zeta.x = newx + x;
          zeta.y = newy + y;
          zeta.z = newz + z;
          
          
          iteration++;
          
          if (sphereZeta.r>2){
            lastIteration = iteration;
             if (edge) {
              edge = false;
            }
           break;
          }
          if (iteration > maxIteration){
             if (!edge) {
              edge = true;
              mandelBulb.add(new MandelPoint(new PVector(x, y, z),lastIteration));
             }
            break;
          }
        
        }
     
      }
    }
  }
  
  
  
  
  
  
  

  
  
  
}


class spherical{
  float r,theta, phi;
  spherical(float r, float theta, float phi){
    this.r = r;
    this.theta = theta;
    this.phi = phi;
  }
  
}

spherical sphere(float x, float y, float z){
        float r = sqrt(x*x + y*y + z*z);
        float theta = atan2( sqrt(x*x+y*y) ,z);
        float phi = atan2(y,x);
        return new spherical(r,theta,phi);
}


void draw() {
  background(0);
  colorMode(HSB, 255);
  for (MandelPoint p : mandelBulb){
    stroke(255);
        stroke(map(p.i, 0, maxIteration, 255, 0), 255, 255);

   point(p.v.x*200, p.v.y*200, p.v.z*200); 
  }
  
  
}
