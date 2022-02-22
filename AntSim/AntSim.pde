 //<>//

PImage sprite;
Colony[] colonyList = new Colony[5];
ArrayList<Food> foodList;
pheromon[][] pheromonGrid;
Food[][] foodGrid;

boolean showPher;


void setup() {
  size(800, 800, P2D);
  background(80);
  frameRate(60);

  pheromonGrid = new pheromon[width+1][height+1];
  foodGrid = new Food[width+1][height+1];

  colonyList[1] = new Colony(new PVector(width/2, height/2), 250, 1);

  sprite = loadImage("ant_2.png");
  sprite.resize(sprite.width/8, sprite.height/8);

  foodList = new ArrayList<Food>();
}


void draw() {
  background(25);


  if (mousePressed) {
    if (mouseButton ==LEFT) {
      for (int i = 0; i < 10; i++) {
        int x = mouseX + (int)random(-20, 20);
        int y = mouseY + (int)random(-20, 20);

        if (foodGrid[x][y] == null) {
          foodGrid[x][y] = new Food(x, y);
        } else {
          foodGrid[x][y].quantity++;
        }
      }
    } else if (mouseButton == RIGHT) {
      for (int i = 0; i < 10; i++) {
        int x = mouseX + (int)random(-5, 5);
        int y = mouseY + (int)random(-5, 5);

        pheromonGrid[(int)x][(int)y] = new pheromon(new PVector(x, y), "toFood");
      }
    }
  }


    colonyList[1].display();
    colonyList[1].update();


    /*
  for (pheromon[] u: pheromonGrid){
     for (pheromon pher : u){
     if (pher != null){
     pher.show();
     pher.update();
     }
     
     }
     }
     */

    for (int i = 0; i < width+1; i++) {
      for (int j = 0; j < height+1; j++) {
        if (pheromonGrid[i][j] != null) {
          if (showPher) {

            pheromonGrid[i][j].show();
          }
          pheromonGrid[i][j].update();
        }
        if (foodGrid[i][j] != null) {
          foodGrid[i][j].display();
        }
      }
    }
  }


  void keyPressed() {
    if (key == ' ') {



      showPher = !showPher;
    }
  }


  void mouseClicked() {
    //foodList.add(new Food(mouseX, mouseY));
    //pheromonGrid[(int)mouseX][(int)mouseY] = new pheromon(new PVector(mouseX, mouseY), "toFood");
  }
