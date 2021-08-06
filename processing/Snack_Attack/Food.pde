//food object acting as notes for rhythm game

class Food extends Object {
  boolean hit;
  PImage food;
  int random = (int) random(1, 10);

  Food(float x, float y, float xSpd, float ySpd) {
    super(x, y, xSpd, ySpd);
    food = loadImage("data/food/food-"+random+".png");
    diameter = new PVector(100, 100);
  }

  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    image(food, 0, 0);
    popMatrix();
  }

  void animate() {
    pos.add(vel);
  }

  void update() {
    render(); 
    animate();
  }
  
  //check if food is ontop of button
  boolean hitObject(Object o) {
    if ((pos.x - o.pos.x) < (diameter.x/2 + o.diameter.x/2) && abs(pos.y - o.pos.y) < (diameter.y/2 + o.diameter.y/2)){
      return true;
    }
    else {
      return false;
    }
  }
}
