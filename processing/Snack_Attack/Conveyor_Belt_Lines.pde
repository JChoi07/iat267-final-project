class ConveyorBeltLines extends Object {
  color conveyorBeltLine = color(91, 89, 89);
  PVector diameter;

  ConveyorBeltLines(float x, float y, float xSpd, float ySpd) {
    super(x, y, xSpd, ySpd);
    xSpd = 3;
    diameter = new PVector(5, 80);
    vel = new PVector(-3, 0);
  }

  void render() {
    pushMatrix();
    fill(conveyorBeltLine);
    rectMode(CORNER);
    translate(pos.x, pos.y);
    rect(0, 0, diameter.x, diameter.y);
    popMatrix();
  }
  
  void animate(){
    pos.add(vel); 
  }
  
  void update(){
    render(); 
    animate();
  }
}
