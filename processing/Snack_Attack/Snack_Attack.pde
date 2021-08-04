void setup() {
  size(1920, 1080);
  loadAssets();
  createSerialConnection();
  playBGM(HOME_BGM);
}

private static final int HELP_SCREEN_STATE = -1;
private static final int HOME_SCREEN_STATE = 0;
private static final int GAMEPLAY_SCREEN_STATE = 1;

void draw() {
  //run game states
  switch(gameState) {
  case GAMEPLAY_SCREEN_STATE:
    gameStart();
    break;
  case HOME_SCREEN_STATE:
    homeScreen();
    break;
  case HELP_SCREEN_STATE:
    helpScreen();
    break;
  }

  //run arduino interactions
  //readSerialConnection();
  touchInput();
  volumeControl();
  //println(up, down, left, right);
}
