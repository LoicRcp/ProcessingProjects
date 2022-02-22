


int dotNb = 20000;
dot[] dots = new dot[dotNb];

String mapName = "candice.png";
PImage map;
boolean showImage = false;

boolean releaseDots = false;

ArrayList<dotSpawnPoint> spawns = new ArrayList<dotSpawnPoint>();


int dyingChancePercent = 1;


void setup() {
  background(160);
  size(988, 800, P2D);


  map = loadImage(mapName);
  map.loadPixels();
}

void draw() {
  background(255);

  if (releaseDots) {
    for (int i=0; i < dotNb; i++) {
      dots[i].showDot();
      dots[i].moveDot();
      dots[i].checkDeath();
    }
  }
  for (dotSpawnPoint spawn : spawns) {
    spawn.show();
  }

  
  if (showImage){
   image(map,0,0); 
  }
  
  
  text("DyingChancePercent: "+dyingChancePercent+"%", 10, 20);
}


void mouseClicked() {

  if (mouseButton == RIGHT) {
    spawns.add(new dotSpawnPoint(new PVector(mouseX, mouseY), spawns.size()+1));
  }
}


void keyPressed() {
  if (key == ' ' ) {
    
    if (!releaseDots) {
      for (int i=0; i < dotNb; i++) {
        int spawnId = int(random(0, spawns.size()));
        dots[i] = new dot(spawns.get(spawnId).pos.copy(), spawnId);
      }
      releaseDots = true;
    } else {

      for (int i=0; i < dotNb; i++) {
        if (!dots[i].dead) {
          int spawnId = int(random(0, spawns.size()));
          dots[i] = new dot(spawns.get(spawnId).pos.copy(), spawnId);
        }
      }
    }
  }

if (key == 'n') {
   
      
    showImage = !showImage;
  
   }

if (key == 'b') {
   
      
    spawns.add(new dotSpawnPoint(new PVector(mouseX, mouseY), spawns.size()+1));
  
   }

  if (key == 'x') {
    spawns = new ArrayList<dotSpawnPoint>();
    releaseDots = false;
  }
  if (key == 'c') {
    dyingChancePercent+=5;
  }
  if (key == 'v') {
    dyingChancePercent-=5;
  }

  
}
