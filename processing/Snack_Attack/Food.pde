class Food extends Object {
  boolean hit;
  PImage food;
  int random = (int) random(1, 10);

  Food(float x, float y, float xSpd, float ySpd) {
    super(x, y, xSpd, ySpd);
    food = loadImage("data/food/food-"+random+".png");
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

  void checkCollision() {


    //boolean hitCharacter(Characters c) {
    //  return abs(pos.x - c.pos.x) < (dim.x/2 + c.dim.x/2) && abs(pos.y - c.pos.y) < (dim.y/2 + c.dim.y/2);
    //}
  }
}
