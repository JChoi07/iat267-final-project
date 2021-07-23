class Chef extends Object {
  PImage sprite;

  Chef (float x, float y, float xSpd, float ySpd, float scale) {
    super(x, y, xSpd, ySpd);
    this.scale = scale;
    sprite = loadImage("chef-sprite.png");
  }

  void update() {
    standby();
  }

  void render() {
  }

  void standby() {
    x = (counter % 4) * w;
    y = 0;

    pushMatrix();
    translate(pos.x, pos.y);
    scale(.7);
    copy(sprite, x, y, w, w, 0, 0, w, w);
    popMatrix();

    if (frameCount % 6 == 0) {
      counter = counter + 1;
    }
  }
}
