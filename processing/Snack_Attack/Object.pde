class Object {
  protected PVector pos, vel;
  protected int w, h;
  protected float scale;

  Object(float x, float y, float xSpd, float ySpd) {
    pos = new PVector (x, y);
    vel = new PVector (xSpd, ySpd);
  }

  void render() {
  }

  void update() {
    pos.add(vel);
  }
}
