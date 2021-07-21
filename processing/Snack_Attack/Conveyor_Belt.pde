class ConveyorBelt extends Object {

  color conveyorBeltColor = color(56, 53, 53);

  ConveyorBelt(float x, float y, float xSpd, float ySpd) {
    super(x, y, xSpd, ySpd);
  }

  void render() {
    fill(conveyorBeltColor);
    rect(0, width, 0, 80);
  }
}
