import processing.video.*;

Capture video;
//PImage video;
String density = "Ñ@#W$9876543210?!abc;:+=-,._                    ";

void setup() {
    size(1920,1080);
    int divisor = 15;
   video = new Capture(this,1920/divisor,1080/divisor, "pipeline:autovideosrc");

   video.start();
   //video = loadImage("test2.jpg");

  println(density.length());
}




void draw(){
  background(0);
  
  if (video.available()) {
     video.read();
  }
 
 //image(video,0,0,width,height);
  
  
  
  int w = width/video.width;
  int h = height/video.height;
  //loadPixels();
  video.loadPixels();



  for (int i = 0; i < video.width; i+=1){
    for(int j = 0; j < video.height; j+=1){
      int index =(i+j*video.width);
     float r = red(video.pixels[index]); //<>//
     float g = green(video.pixels[index]);
     float b = blue(video.pixels[index]);
     float brightness = brightness(video.pixels[index]);
     
     
     fill(r,g,b, brightness);
     //fill(r,g,b);
     
     noStroke();
     //square(i*w,j*h,w);
     textSize(w);
     textAlign(CENTER,CENTER);
     
     int letterIndex = floor(map(brightness,255,0,0,density.length()-1));
     char letter = density.charAt(letterIndex);
     
    text(letter, i*w+w*0.5,j*h+h*0.5);
  }
  }
}
