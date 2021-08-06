/*===============
REFERENCES

Chef Character Sprite:
https://opengameart.org/content/chef-animated-classic-hero-edit

Kitchen Assets:
https://opengameart.org/content/kitchen-assets-for-letscookjam

Food Assets:
https://thewisehedgehog.itch.io/thfp

Background Music (Home and Help Screen):
Fibbage 3 Lobby Music
https://www.youtube.com/watch?v=-ag1NNTZJ3I&ab_channel=AndyPoland-Topic

Game Music (Game Screen):
Stardust Speedway Act 1 from Sonic
https://www.youtube.com/watch?v=XSf3IP7k-Rk&t=97s&ab_channel=DeoxysPrime

Restaurant Ambience (Game End Screen):
https://www.youtube.com/watch?v=AJZmie7z4_c&t=109s&ab_channel=AllThingsGrammar

Typeface:
LORES by Adobe
https://fonts.adobe.com/fonts/lo-res

===============*/

void setup() {
  size(1920, 1080);
  loadAssets();
  createSerialConnection();
  playBGM(HOME_BGM);
}

private static final int HELP_SCREEN_STATE = -1;
private static final int HOME_SCREEN_STATE = 0;
private static final int GAMEPLAY_SCREEN_STATE = 1;
private static final int END_SCREEN_STATE = 2;

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
  case END_SCREEN_STATE:
    endScreen();
    break;
  }

  //run arduino interactions
  readSerialConnection();
  touchInput();
  volumeControl();
  println(song1Timer, gameSpeed);
}
