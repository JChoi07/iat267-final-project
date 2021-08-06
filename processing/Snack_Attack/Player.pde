//player class used to control main chef

class Player extends Chef {
  Player (float x, float y, float xSpd, float ySpd, float scale) {
    super(x, y, xSpd, ySpd, scale);
  }
  
  void render() {
    stateUpdate();
    frameUpdate();
  }

  @Override
    void stateUpdate() {
    if (left) {
      state = PUNCHING_STATE;
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
}
