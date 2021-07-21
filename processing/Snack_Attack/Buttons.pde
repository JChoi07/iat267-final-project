class Buttons extends Object {

  color buttonColor = color(56, 53, 53);
  boolean state;

  Buttons(float x, float y, float xSpd, float ySpd) {
    super(x, y, xSpd, ySpd);
  }

  void render() {
    fill(buttonColor);
    rect(0, width, 0, 80);
  }
  
  void updateColor(){
  }
}
