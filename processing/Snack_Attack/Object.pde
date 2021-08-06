//object superclass used to hold similar methods for other objects

class Object {
  protected PVector pos, vel, diameter;
  protected int w, h;
  protected float scale;

  Object(float x, float y, float xSpd, float ySpd) {
    pos = new PVector (x, y);
    vel = new PVector (xSpd, ySpd);
    diameter = new PVector(0, 0);
  }

  void render() {
  }

  void update() {
    pos.add(vel);
  }
}
