//conveyor belt lines that move to simulate movement of the conveyor belt

class ConveyorBeltLines extends Object {
  color conveyorBeltLine = color(91, 89, 89);
  PVector diameter;

  ConveyorBeltLines(float x, float y, float xSpd, float ySpd) {
    super(x, y, xSpd, ySpd);
    diameter = new PVector(5, 80);
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
    if (pos.x < 102){
      pos.x = width; 
    }
  }
  
  void update(){
    render(); 
    animate();
  }
}
