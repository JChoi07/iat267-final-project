class Chef extends Object {
  protected int state, currentImgIndex;
  protected PImage [] standing, walking, flying, punching;
  protected int previousState = 0;

  float damp = 0.8;

  Chef (float x, float y, float xSpd, float ySpd) {
    super(x, y, xSpd, ySpd);
  }
  
  void update(){
  }

  void render() {
    PImage img;

    pushMatrix();
    translate(pos.x, pos.y);

    scale(scale);

    if (vel.x < 0) {
      scale(-1, 1);
    }

    switch (state) {
    case 0:
      img = standing[currentImgIndex];
      image(img, -img.width/2, -img.height/2);
      break;
    case 1:
      img = walking[currentImgIndex];
      image(img, -img.width/2, -img.height/2);
      break;
    case 2:    
      img = flying[currentImgIndex];
      image(img, -img.width/2, -img.height/2);
      break;
    case 3:
      img = punching[currentImgIndex];
      image(img, -img.width/2, -img.height/2);
      break;
    }

    popMatrix();
  }
}
