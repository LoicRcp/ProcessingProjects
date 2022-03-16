import peasy.*;


int dimension =32;
PeasyCam cam;

void setup(){
 size(800,800,P3D);
 lights();
 
 cam = new PeasyCam(this,500);
 
 
  
}


void draw(){
  background(0);
  for(int i=0; i < dimension; i++){
    for(int j=0; j < dimension; j++){
      for(int k=0; k < dimension; k++){
         
        float x = map(i,0,dimension, -100, 100);
        float y = map(j,0,dimension, -100, 100);
        float z = map(k,0,dimension, -100, 100);
        stroke(255,255,255);
        point(x,y,z);
      }
      
       
    }
    
     
  }
  
  
  
  
}
