//button class used as hitbox for food

class Buttons extends Object {
  color buttonColor = color(180, 171, 171);
  color buttonStroke = color(61, 61, 61);
  color buttonReflection = color(219, 215, 215);
  boolean state;
  PVector diameter, buttonReflectionDiameter;
  
  boolean downArrowTrue;

  Buttons(float x, float y, float xSpd, float ySpd) {
    super(x, y, xSpd, ySpd);
    diameter = new PVector(140, 95);
    buttonReflectionDiameter = new PVector(130, 6);
  }

  void render() {
    pushMatrix();
    translate(pos.x + diameter.x/2, pos.y + diameter.y/2);
    
    //main button
    fill(buttonColor);
    rectMode(CENTER);
    strokeWeight(2);
    stroke(buttonStroke);
    rect(0, 0, diameter.x, diameter.y, 0, 10, 10, 0);
    
    //button reflection
    fill(buttonReflection);
    noStroke();
    rect(-5, diameter.y/2 - 10, buttonReflectionDiameter.x, buttonReflectionDiameter.y, 0, 0, 10, 0);

    popMatrix();
  }
  
  void updateColor(){
  }
  
  void update() {
    render();
    updateColor();
  }
}
