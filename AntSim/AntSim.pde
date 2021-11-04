

PImage sprite;
Colony[] colonyList = new Colony[5];
ArrayList<Food> foodList;
pheromon[][] pheromonGrid;

void setup(){ //<>//
 size(800,800);
 background(80);
 frameRate(60);
 
 pheromonGrid = new pheromon[width+1][height+1];
 
 colonyList[1] = new Colony(new PVector(width/2,height/2),359,1);
  
 sprite = loadImage("ant_2.png");
 sprite.resize(sprite.width/8,sprite.height/8);
 
 foodList = new ArrayList<Food>();
 
}


void draw(){
 background(80);
 
 colonyList[1].display();
 colonyList[1].update();
 
 for(Food food : foodList){
   food.display();
 }
 
  for (pheromon[] u: pheromonGrid){
      for (pheromon pher : u){
        if (pher != null){
          pher.show();
          pher.update();
        }
        
      }
  }
    
 
 
 
 
 
  
  
}



void mouseClicked() {
  foodList.add(new Food(mouseX,mouseY));
  
}
