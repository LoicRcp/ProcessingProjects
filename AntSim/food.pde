class Food {

  int x, y;
  int quantity;
  Food(int _x, int _y) {
    x = _x;
    y = _y;
    quantity = 1;
  }


  void display() {

    if (quantity<=0) { 
      foodGrid[x][y] = null; 
      return;
    }

    fill(50, 200, 50);
    circle(x, y, 2);
  }
}
