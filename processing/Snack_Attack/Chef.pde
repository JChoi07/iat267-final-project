//chef superclass that holds methods used by background chefs and the main player chef

class Chef extends Object {
  PImage sprite;
  int w = 200;
  int state = 0;

  protected static final int DEFAULT_STATE = 0;
  protected static final int PUNCHING_STATE = 1;
  protected static final int FLYING_STATE = 2;
  protected static final int RUNNING_STATE = 3;

  Chef (float x, float y, float xSpd, float ySpd, float scale) {
    super(x, y, xSpd, ySpd);
    this.scale = scale;
    sprite = loadImage("chef-sprite.png");
  }

  void update() {
    super.update();
    if (pos.x > width - w/5 || pos.x < w/5) {
      vel.x *= -1;
    }
  }

  void render() {
    if (vel.x < 0) {
      pushMatrix();
      scale(-1, 1);
      popMatrix();
    }
    run();
    update();
    stateUpdate();
  }

  void stateUpdate() {
    state = DEFAULT_STATE;
  }

  /*============
   CHEF STATES
   ============*/

  void run() {
    x = (counter % 6) * w;
    y = 201;

    pushMatrix();
    translate(pos.x, pos.y - w/2 + 30);
    scale(scale);
    if (vel.x < 0) {
      scale(-1, 1);
    }
    copy(sprite, x, y, w, w, -w/2, 0, w, w);
    popMatrix();

    if (frameCount % 2 == 0) {
      counter = counter + 1;
    }
  }

  void fly() {
    x = (counter % 6) * w;
    y = 401;

    pushMatrix();
    translate(pos.x - w/2, pos.y - w/2 -50);
    scale(scale);
    copy(sprite, x, y, w, w, 0, 0, w, w);
    popMatrix();

    if (frameCount % 4 == 0) {
      counter = counter + 1;
    }
  }

  void punch() {
    x = (counter % 3) * w;
    y = 600;

    pushMatrix();
    translate(pos.x, pos.y - w/2);
    if (left) {
      scale(-1, 1);
      translate(w/2, 0);
    } else if (right) {
      translate(w, 0);
    }

    scale(scale);
    copy(sprite, x, y, w, w, -w/2, 0, w, w);
    popMatrix();

    if (frameCount % 4 == 0) {
      counter = counter + 1;
    }
  }

  void standby() {
    x = (counter % 3) * w;
    y = 0;

    pushMatrix();
    translate(pos.x - w/2, pos.y - w/2);
    scale(scale);
    copy(sprite, x, y, w, w, 0, 0, w, w);
    popMatrix();

    if (frameCount % 10 == 0) {
      counter = counter + 1;
    }
  }
}
