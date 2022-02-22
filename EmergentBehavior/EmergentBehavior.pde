int gridCellSize = 5;
int cellNumber = (width*height)/gridCellSize;
int baseColor = 131;
float tailleLight = 1;
boolean randomDelai;
 int lowestNumber;
boolean checkerStroke;
boolean HUD;
boolean grille;
int circleNumber = 6;

grid[] grid = new grid[int(sq(1000/gridCellSize))];

circleCell[] circleCell = new circleCell[circleNumber];
checker[] check = new checker[circleNumber];
boolean[] blinkArray = new boolean[circleNumber];


float r2 = 74;
float g2 = 245;
float b2 = 126;

//r2 = 74;
//g2 = 245;
//b2 = 126;

void setup() {
  size (1000, 1000);

  int x, y;
  int i = -1;

  for (y = 0; y < width; y = y + gridCellSize) {
    for (x = 0; x < height; x = x + gridCellSize) {
      i++;
      grid[i] = new grid(x, y, gridCellSize, i);
    }
  }
for (int o = 0; i < blinkArray.length; i++){
    blinkArray[o] = false;
  
  
}

for (int a = 0; a< circleCell.length; a++){
    circleCell[a] = new circleCell(a);
    check[a] = new checker(a);
  
  
  
}
  //circleCell[0] = new circleCell(450, 450, 100,0);
  //circleCell[1] = new circleCell(450, 550, 100,1);
  //circleCell[2] = new circleCell(550, 450, 100,2);
  //circleCell[3] = new circleCell(550, 550, 100,3);
  //check[0] = new checker(450, 450, 200, 0);
  //check[1] = new checker(450, 550, 200, 1);
  //check[2] = new checker(550, 450, 200, 2);
  //check[3] = new checker(550, 550, 200, 3);
}




void draw() {

println(checkerStroke);
  background(80);
  for (int i = 0; i < grid.length; i++) {
    grid[i].display();
    grid[i].update();
  }
  for (int i = 0; i < circleCell.length; i++) {
    circleCell[i].delai();
    if (randomDelai == true) {
      circleCell[i].update();
    }
  }
  for (int o = 0; o < circleCell.length; o++) {

    circleCell[o].display();
    check[o].display();
    check[o].update();
  }



//println(blinkArray[0]);
//println(blinkArray[1]);
//println(grid[323].localG2, grid[323].y);
//println(check[0].checkOverlap(check[1].x,check[1].y,check[1].diameter));
if (randomDelai ==true){
for (int i = 0; i < (circleCell.length); i++){ 
  for (int o = 0; o < (circleCell.length); o++){
      if ((check[i].checkOverlap(check[o].x,check[o].y,check[o].diameter) == true )){
//         for (int p = 0; p < (circleCell.length); p++){
            if ((blinkArray[o] == true)){
                if ( i != o){
                   circleCell[i].increaseUrge(); //<>//
          }
        }
      
      
//    }
    
    
    
  }

}
 
 
 
  
}
for (int p = 0; p < (circleCell.length); p++){
  blinkArray[p] = false; 

}
}




}








void mousePressed() {

  for (int i = 0; i < grid.length; i++) {
    grid[i].mouseClick(mouseX, mouseY);
  }
}

void mouseDragged(){

  for (int i = 0; i < circleCell.length; i++){
  if ((dist(mouseX,mouseY, circleCell[i].x, circleCell[i].y))<= circleCell[i].diameter){
   circleCell[i].x = mouseX;
   circleCell[i].y = mouseY; 
  }
  }
  }

void keyPressed() {
  if (key == ' ') {
    for (int i = 0; i < circleCell.length; i++) {
      circleCell[i].reset();
    }
  }

 if(key =='c'){
   if (checkerStroke == true){
     checkerStroke = false;
   }
   else if (checkerStroke == false){
     checkerStroke = true;
   }
}
 if(key =='h'){
   if (HUD == true){
     HUD = false;
   }
   else if (HUD == false){
     HUD = true;
   }
}
 if(key =='g'){
   if (grille == true){
     grille = false;
   }
   else if (grille == false){
     grille = true;
   }
}
}




// if(key =='c'){
//   if (checkerStroke == true){
//     checkerStroke = false;
//   }
//    if (checkerStroke == false){
//     checkerStroke = true;
//   }
//}

  
