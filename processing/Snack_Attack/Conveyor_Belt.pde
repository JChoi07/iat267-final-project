class ConveyorBelt extends Object {
  ArrayList<ConveyorBeltLines> cbLines = new ArrayList<ConveyorBeltLines>();
  
  color conveyorBeltColor = color(56, 53, 53);
  color conveyorBeltStroke = color(91, 89, 89);
  PVector diameter;

  ConveyorBelt(float x, float y, float xSpd, float ySpd) {
    super(x, y, xSpd, ySpd);
    diameter = new PVector(width, 80);
  }

  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(conveyorBeltColor);
    stroke(conveyorBeltStroke);
    strokeWeight(3);
    rectMode(CORNER);
    rect(0, 0, diameter.x, diameter.y);
    popMatrix();
  }
 
  void setUpLines() {
    for(int i = 0; i<25; i++){
      cbLines.add(new ConveyorBeltLines(0 + (100 * i), pos.y, 0, 0));
   }
  }

  void animateLines() {
   for(int i = 0; i<cbLines.size(); i++){
     ConveyorBeltLines cbL = cbLines.get(i);
     cbL.update();
   }
  }
  

  void update(){
    render(); 
    //setUpLines();
    //animateLines();
  }
}
