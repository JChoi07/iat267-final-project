class Player extends Chef {
  boolean up, right, left, down;
  int state = 0;

  private static final int DEFAULT_STATE = 0;
  private static final int PUNCHING_STATE = 1;
  private static final int FLYING_STATE = 2;
  private static final int RUNNING_STATE = 3;

  Player (float x, float y, float xSpd, float ySpd, float scale) {
    super(x, y, xSpd, ySpd, scale);
  }

  void render() {
    stateUpdate();
    frameUpdate();
  }

  void keyPressed() {
    if (key == 'a' || key == 'A') {
      left = true;
    } else if (key == 's' || key == 'S') {
      down = true;
    } else if (key == 'w' || key == 'W') {
      up = true;
    } else if (key == 'd' || key == 'D') {
      right = true;
    } else {
      left = false;
      down = false;
      up = false;
      right = false;
    }
  }

  void stateUpdate() {
    if (left) {
      state = PUNCHING_STATE;
      scale(-1, 1);
    } else if (right) {
      state = PUNCHING_STATE;
    } else if (up) {
      state = FLYING_STATE;
    } else if (down) {
      state = RUNNING_STATE;
    } else {
      state = DEFAULT_STATE;
    }
  }

  void frameUpdate() {
    switch(state) {
    case DEFAULT_STATE:
      standby();
      break;
    case PUNCHING_STATE:
      punch();
      break;
    case FLYING_STATE:
      fly();
      break;
    case RUNNING_STATE:
      run();
      break;
    }
  }

  /*============
   CHEF STATES
   ============*/

  void run() {
    x = (counter % 6) * w;
    y = 201;

    pushMatrix();
    translate(pos.x, pos.y);
    scale(scale);
    copy(sprite, x, y, w, w, 0, 0, w, w);
    popMatrix();

    if (frameCount % 6 == 0) {
      counter = counter + 1;
    }
  }

  void fly() {
    x = (counter % 6) * w;
    y = 401;

    pushMatrix();
    translate(pos.x, pos.y);
    scale(scale);
    copy(sprite, x, y, w, w, 0, 0, w, w);
    popMatrix();

    if (frameCount % 6 == 0) {
      counter = counter + 1;
    }
  }

  void punch() {
    x = (counter % 3) * w;
    y = 600;

    pushMatrix();
    translate(pos.x, pos.y);
    scale(scale);
    copy(sprite, x, y, w, w, 0, 0, w, w);
    popMatrix();

    if (frameCount % 6 == 0) {
      counter = counter + 1;
    }
  }
}
