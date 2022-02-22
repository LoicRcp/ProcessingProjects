class cells { //<>// //<>// //<>// //<>// //<>// //<>// //<>//
  int x, y, size, number;
  String type;
  color clr;
  IntList neighbor = new IntList();
  int counter = 0;
  boolean Resistance;
  int infectedNeighbor = 0;
  boolean sickInit = false;
  int tpsGuerison;
  int tpsMort;
  float weakness;
  cells(int _x, int _y, int _size, int _number) {
    x = _x;
    y = _y;
    size = _size;
    number = _number;



    float typeNumber = random(0, 1);
    if (typeNumber >= 0 && typeNumber <= (0 + healthyRate)) {
      type = "healthy";
    } else if (typeNumber > (0 + healthyRate)  && typeNumber <= (healthyRate + sickRate )) {
      type = "sick";
    } else if (typeNumber > (0 + healthyRate + sickRate)  && typeNumber <= 0 + healthyRate + sickRate + immunisedRate ) {
      type = "immunised";
    }
  
  weakness = random(0.65,1.35);
}


  void identifyType() {
    if (type == "healthy") {
      clr = #03FF65;
    }
    if (type == "sick") {
      clr = #FF0000;
    }
    if (type == "dead") {
      clr = #393939;
    }

    if (type == "immunised") {
     // clr = #002CFF;
     clr = #03FF65;
    }
  }

  void display() {

    fill(clr);
    noStroke();
    square(x, y, size);

    
     /*textAlign(CENTER);
     textSize(10);
     fill(0);
     text(number, x+size/2, y+size/2);
     */
  }

  /*
   Cas 1: Cellules tout en haut, ne peut pas prendre des cellules plus haut car elles n'existent pas
   Cas 2: Cellules tout en bas, ne peut pas prendre des cellules plus bas car elles n'existent pas
   Cas 3: Cellules tout a gauche
   Cas 4: Cellules tout a droite
   
   
   */

  void identifyNeighbor() {
    neighbor.clear();
    String Case = "0";
    if (0 <= number && number < (1000/gridCellSize) && (number % (1000/gridCellSize) == 0)) {
      Case ="1+3";
    }     // Cas de Figure 1 + 3
    else if (0 <= number && number < (1000/gridCellSize) && (number+1) % (1000/gridCellSize) == 0) { 
      Case ="1+4";
    }      // Cas de Figure 1 + 4
    else if ((grid[grid.length-1].number) - (1000/gridCellSize) < number && number <= grid[grid.length-1].number && (number % (1000/gridCellSize) == 0)) {  
      Case ="2+3";
    }      // Cas de Figure 2 + 3

    else if ((grid[grid.length-1].number) - (1000/gridCellSize) < number && number <= grid[grid.length-1].number && (number+1) % (1000/gridCellSize) == 0) {  
      Case ="2+4";
    }      // Cas de Figure 2 + 4

    else if (0 <= number && number < (1000/gridCellSize)) { 
      Case ="1";
    } // Cas de Figure 1

    else if ((grid[grid.length-1].number) - (1000/gridCellSize) < number && number <= grid[grid.length-1].number) {
      Case ="2";
    }  // Cas de Figure 2
    // println(number, "cas 2");

    else if (number % (1000/gridCellSize) == 0) { 
      Case ="3";
    }  // Cas de Figure 3

    else if ((number+1) % (1000/gridCellSize) == 0) {
      Case ="4";
    } // Cas de Figure 4

    else { 
      Case ="5";
    } 


    switch(Case) {
    case "1+3":
    neighbor.append(new int[] {number+1, number+(1000/gridCellSize), (number +(1000/gridCellSize))+1});
      break;
    case  "1+4":
    neighbor.append(new int[] {number-1, (number + (1000/gridCellSize))-1, number+(1000/gridCellSize)});
      break;  
    case  "2+3":
    neighbor.append(new int[] { number - (1000/gridCellSize), (number - (1000/gridCellSize))+1, number+1});
      break;
    case  "2+4":
    neighbor.append(new int[] {(number-(1000/gridCellSize))-1, number - (1000/gridCellSize), number-1});
      break;
    case  "1":
    neighbor.append(new int[] {number-1, number+1, (number + (1000/gridCellSize))-1, number+(1000/gridCellSize), (number +(1000/gridCellSize))+1});
      break;
    case  "2":
    neighbor.append(new int[] {(number-(1000/gridCellSize))-1, number - (1000/gridCellSize), (number - (1000/gridCellSize))+1, number-1, number+1});
      break;
    case  "3":
    neighbor.append(new int[] { number - (1000/gridCellSize), (number - (1000/gridCellSize))+1, number+1, number+(1000/gridCellSize), (number +(1000/gridCellSize))+1});
      break;
    case "4":
    neighbor.append(new int[] {number-(1000/gridCellSize)-1, number - (1000/gridCellSize), number-1, number + ((1000/gridCellSize)-1), number+(1000/gridCellSize)});
      break;
    case  "5":
      
    neighbor.append(new int[] {(number-(1000/gridCellSize))-1, number - (1000/gridCellSize), (number - (1000/gridCellSize))+1, number-1, number+1, (number + (1000/gridCellSize))-1, number+(1000/gridCellSize), (number +(1000/gridCellSize))+1});
      break;
    }}


    void checkNeighbors() {
      if (number==93) {

        //println("debug");
      }
      infectedNeighbor = 0;
      for (int i = 0; i < neighbor.size(); i++) {
        if (grid[neighbor.get(i)].type == "sick") {
          infectedNeighbor++;
        }
      }
      //println("Cell's ", number, "is ", type, "and his neighbors are: ", neighbor, "and ", infectedNeighbor, " of them are infected");
    }


    void update() {
      counter++;
      switch(type) {

      case "healthy":
        float infectiosityTest = random(0, 1);
        if (infectiosityTest < infectedNeighbor * infectiosity) {
          type = "sick";
        }
        break;

      case "sick":
        if (!sickInit) {
          sickInit = true;
          float cellResistance = random(0, 1);
          if (cellResistance < resistanceRate) {
            Resistance = true;
          } else {
            Resistance = false;
          }

          if (Resistance) {
            tpsGuerison = counter + int(weakness * recoveryTime);
          }
          if (!Resistance) {
            tpsMort = counter + int(weakness * deathTime);
          }
        }
        if ((sickInit && Resistance) && counter >= tpsGuerison) {
          sickInit = false;
          float imunityTest = random(0, 1);
          if (imunityTest < immunityRate) {
            type = "immunised";
          } else {
            type = "healthy";
          }
        }
        if ((sickInit && !Resistance) && counter >= tpsMort) {
          type = "dead";
        }
      }
    }
  }


  /*
      if (Resistance) {
   if (!sickInit) {
   sickInit = true;
   
   } else if (sickInit && counter >= tpsGuerison) {
   type = "healthy";
   }
   } else if (!Resistance) {
   if (!sickInit) {
   sickInit = true;
   tpsMort = counter + deathTime;
   float cellResistance = random(0.1);
   if (cellResistance <= resistanceRate) {
   Resistance = true;
   } else {
   Resistance = false;
   }
   } else if (sickInit && counter >= tpsMort) {
   type = "dead";
   }
   }
   }
   }
   }
   */



  // Identifier les cellules en fonction du cas, et leur affecter une couleur
  /*
  void identifyNeighbor() {
   
   
   if (0 <= number && number < (1000/gridCellSize) && (number % (1000/gridCellSize) == 0)) {      // Cas de Figure 1 + 3
   println(number, "cas 1 + 3");
   clr = #FF940A;
   } else if (0 <= number && number < (1000/gridCellSize) && (number+1) % (1000/gridCellSize) == 0) {       // Cas de Figure 1 + 4
   println(number, "cas 1 + 4");
   clr = #FF0AF6;
   } else if ((grid[grid.length-1].number) - (1000/gridCellSize) < number && number <= grid[grid.length-1].number && (number % (1000/gridCellSize) == 0)) {       // Cas de Figure 2 + 3
   println(number, "cas 2 + 3");
   clr = #0AFFD6;
   } else if ((grid[grid.length-1].number) - (1000/gridCellSize) < number && number <= grid[grid.length-1].number && (number+1) % (1000/gridCellSize) == 0) {       // Cas de Figure 2 + 4
   println(number, "cas 2 + 4");
   clr = #98FF23;
   } else if (0 <= number && number < (1000/gridCellSize)) { // Cas de Figure 1
   println(number, "cas 1");
   clr = #FF0A0A;
   } else if ((grid[grid.length-1].number) - (1000/gridCellSize) < number && number <= grid[grid.length-1].number) { // Cas de Figure 2
   println(number, "cas 2");
   clr = #16FF0A;
   } else if (number % (1000/gridCellSize) == 0) { // Cas de Figure 3
   println(number, "cas 3");
   clr = #0A8CFF;
   } else if ((number+1) % (1000/gridCellSize) == 0) {// Cas de Figure 4
   println(number, "cas 4");
   clr = #FFF60A;
   } else {
   println(number, "Cas 5");
   clr = #FFFFFF;
   }
   }
   
   
   
   */
