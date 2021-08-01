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

  void checkCollision() {
    //if (pos.x > 141) {    //complete miss
    //  score.updateScore(-10);
    //} 
    //else if (pos.x > 70 && pos.y < 140) {  //slight miss to the right 
    //  score.updateScore(10);
    //}
    //else if (pos.x > 0 && pos.y < 70) {  //slight miss to the left
    //  score.updateScore(10);
    //}
    //else if (pos.x == 70) {   //direct hit
    //  score.updateScore(20);
    //} 
  }
  
  boolean hitObject(Object o) {
    if (abs(pos.x - o.pos.x) < (diameter.x/2 + o.diameter.x/2) && abs(pos.y - o.pos.y) < (diameter.y/2 + o.diameter.y/2)) {
  //    return true;
    }
    else {
      return false;
    }

    
  boolean missObject(Object o) {
    return abs(pos.x - o.pos.x) > (diameter.x/2 + o.diameter.x/2) && abs(pos.y - o.pos.y) > (diameter.y/2 + o.diameter.y/2);
  }
}
