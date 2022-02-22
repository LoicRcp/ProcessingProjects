class Trou{
  
  
  PVector pos;
  int trouWidth;
 Trou(PVector _pos, int _TrouWidth){
   pos = _pos;
   trouWidth = _TrouWidth;
  
 }
  
  void display(){
    stroke(0);
    fill(0);
   circle(pos.x, pos.y, trouWidth);
  }
  
  void checkCollisionWithBall(){
   if (dist(pos.x,pos.y,ball.location.x, ball.location.y) < (trouWidth + ball.ballWidth)/2) {
       PVector location = new PVector(width/4, height/2);
      float ballWidth = 16;
      ball = new Ball(location, ballWidth);
   }
    
  }
  
  
  
}
