//Initialize global variables
PImage gameBg, homeBg, helpMenu, cashScore, upArrow, downArrow, leftArrow, rightArrow;
boolean up, right, left, down;
boolean buttonCheck = false;
boolean buttonEndCheck = false;
int gameState;
int gameSpeed = -10;
int startPage=0;
int gameUI=1;
int w=200;
int counter = 0;
int x, y;
int blink = 255;
int blinkSpeed = 20;
int shakeX, shakeY;
int song1Timer = 2000;
PImage chefSprite;
float r = 255;
float g = 255;
float b = 255;
Score score;

int upBelt = 630;
int rightBelt = 740;
int leftBelt = 850;
int downBelt = 960;
int comboCounter = 1;

//Initialize Arduino serial data and variables
import processing.serial.*;
Serial port;

byte[] inBuffer = new byte[255];
String touchSensorInput = "default";
int touchSensorValue;
int sliderSensorValue;
int buttonValue;

//Initialize sounds/minim
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
Minim m;

//game tracks
final String HOME_BGM = ("music/fibbage-3-lobby-music.mp3");
final String SONG1 = ("music/club-penguin-pizza-parlor.mp3");
final String SONG2 = ("music/Stardust Speedway Zone Act 1 - Sonic Mania [OST].mp3");
final String END_BGM = ("music/restaurant-sound-effect.mp3");
AudioPlayer homeBGM, song1, song2, endBGM;


//Initialize classes and arrays
ArrayList<Chef> bgChefs = new ArrayList<Chef>();
Player player;
ArrayList<Food> foods = new ArrayList<Food>();
ArrayList<Buttons> buttons = new ArrayList<Buttons>();
ArrayList<ConveyorBelt> cBelt = new ArrayList<ConveyorBelt>();
ArrayList<ConveyorBeltLines> cbLines = new ArrayList<ConveyorBeltLines>();
ConveyorBeltLines line;

/*======================
 GAME STATES
 =======================*/

void gameStart() {
  updateGameUI();
  player.render();
}

void homeScreen() {
  score.score = 0;
  song1Timer = 2000;
  gameSpeed = -10;
  blink();
  rgb();
  shake();
  image(homeBg, 0, 0);

  updateBgChefs();
  strokeWeight(0);
  fill(0, 0, 0, 120);
  rect(0, 0, width, height);

  homeText();
}

void helpScreen() {
  blink();
  shake();
  rgb();
  image(homeBg, 0, 0);

  updateBgChefs();
  rectMode(CORNER);
  strokeWeight(0);
  fill(0, 0, 0, 120);
  rect(0, 0, width, height);
  image(helpMenu, 0, 0);

  helpText();
}

void endScreen() {
  pushMatrix();
  blink();
  image(homeBg, 0, 0);
  fill(0, 0, 0, 120);
  rectMode(CORNER);
  rect(0, 0, width, height);

  endText();
  popMatrix();
}

/*=================================
 TEXT ANIMATIONS + SCREEN TEXT
 ==================================*/
void blink() {
  blink += blinkSpeed;

  if (blink > 255 || blink < 0) {
    blinkSpeed *= -1;
  }

  if (keyPressed && key == 'o') {
    gameState = -1;
  }
}

void shake() {
  shakeX += random(-1.5, 1.5);
  shakeY += random(-1.5, 1.5);
}

void rgb() {
  if (frameCount % 12 == 0) {
    r = random(1, 255);
  }
  if (frameCount % 12 == 0) {
    g = random(1, 255);
  }
  if (frameCount % 12 == 0) {
    b = random(1, 255);
  }
}

//draw text for home screen
void homeText() {
  textAlign(CENTER);
  fill(r, g, b);
  textSize(120);
  text("SNACK ATTACK", width/2 + shakeX, height/1.85 - shakeY);

  fill(255, 255, 255, blink);
  textSize(36);
  text("Press Switch to Start", width/2, height/1.6);

  textAlign(LEFT);
  textSize(16);
  fill(255, 255, 255);
  text("Jonathan Choi", 20, height - 65);
  text("David Baik", 20, height - 45);

  //textAlign(RIGHT);
  text("IAT 267", 20, 35);
}

//draw text for help screen
void helpText() {    
  fill(255);
  textSize(72);
  text("SNACK ATTACK", 150, height/4);

  textSize(36);
  textAlign(LEFT);
  fill(r, g, b);
  text("Rush hour", 150 + shakeX, height/3 - shakeY);
  fill(255);
  text("is here and customers are pouring in!", 350, height/3);
  text("Quickly send out the orders to as many customers", 150, height/3 + 35);
  text("as you can! It's the attack of the snacks!", 150, height/3 +70);

  text("on the appropriate pad on the gameboard to", 221, 700);
  fill(255, 255, 255, blink);
  text("Tap", 150, 700);
  fill(255);
  text("send the food out when it reaches the end of the", 150, 735);
  text("conveyor belt.", 150, 770);
}

//draw text for end game screen
void endText() {      
  textSize(72);
  textAlign(CENTER);
  fill(255);
  text("You have earned", width/2, height/2.2);

  image(cashScore, width/2 - 140, height/2);
  textAlign(LEFT);
  textSize(48);
  text("$" + score.score, width/2 - 20, height/2 + 50);

  textAlign(CENTER);
  fill(255, 255, 255, blink);
  textSize(36);
  text("Press Switch to Return", width/2, height - 200);
}

/*=================================
 ARDUINO + PROCESSING INTERACTIONS
 ==================================*/

void createSerialConnection() {
  println("Available serial ports:");
  println(Serial.list());

  port = new Serial(this, "COM3", 9600); //windows laptop
  //port = new Serial(this, "/dev/cu.usbserial-D306DZMR", 9600); //for mac
}

void readSerialConnection() {
  if (0 < port.available()) { // If data is available to read,

    println(" ");

    port.readBytesUntil('&', inBuffer);  //read in all data until '&' is encountered

    if (inBuffer != null) {
      String myString = new String(inBuffer);
      //println(myString);  //for testing only


      //p is all sensor data (with a's and b's) ('&' is eliminated) ///////////////

      String[] p = splitTokens(myString, "&");  
      if (p.length < 2) return;  //exit this function if packet is broken


      //get touch sensor reading //////////////////////////////////////////////////

      String[] touch_sensor = splitTokens(p[0], "a");  //get light sensor reading 
      if (touch_sensor.length != 3) return;  //exit this function if packet is broken
      //println(light_sensor[1]);
      touchSensorValue = int(trim(touch_sensor[1]));

      print("touch sensor:");
      print(touchSensorValue);
      println(" ");  

      //get slider sensor (potentiometer) reading //////////////////////////////////////////////////

      String[] slider_sensor = splitTokens(p[0], "b");  //get slider sensor reading 
      if (slider_sensor.length != 3) return;  //exit this function if packet is broken
      //println(slider_sensor[1]);
      sliderSensorValue = int(slider_sensor[1]);

      print("slider sensor:");
      print(sliderSensorValue);
      println(" "); 

      //get button reading //////////////////////////////////////////////////

      String[] button_switch = splitTokens(p[0], "c");  //get slider sensor reading 
      if (button_switch.length != 3) return;  //exit this function if packet is broken
      //println(slider_sensor[1]);
      buttonValue = int(button_switch[1]);

      print("button value:");
      print(buttonValue);
      println(" ");
    }
  }
}



/*======================
 CREATE OBJECTS
 ========================*/
//set up buttons objects
void createButtons() {
  //button = new Buttons(-5, 620, 0, 0);
  for (int i = 0; i < 4; i++) {
    buttons.add(new Buttons(-5, 620 + (i*110), 0, 0));
  }
}

//set up conveyor belt objects
void createConveyorBelt() {
  for (int i = 0; i < 1; i++) {
    cBelt.add(new ConveyorBelt(138, upBelt, 0, 0));
    cBelt.add(new ConveyorBelt(138, rightBelt, 0, 0));
    cBelt.add(new ConveyorBelt(138, leftBelt, 0, 0));
    cBelt.add(new ConveyorBelt(138, downBelt, 0, 0));
  }
}

//set up background chef objects
void createBgChefs() {
  for (int i = 0; i < 1; i++) {
    bgChefs.add(new Chef(370, 490, -5, 0, .7));
    bgChefs.add(new Chef(1500, 510, 5, 0, .7));
  }
}

//set up conveyor belt line objects
void setUpLines() {
  for (int i = 0; i<14; i++) {                                                  //set up conveyor belt lines for every belt
    cbLines.add(new ConveyorBeltLines(280 + (140 * i), 630, gameSpeed, 0));
    cbLines.add(new ConveyorBeltLines(280 + (140 * i), 630 + 110, gameSpeed, 0));
    cbLines.add(new ConveyorBeltLines(280 + (140 * i), 630 + 220, gameSpeed, 0));
    cbLines.add(new ConveyorBeltLines(280 + (140 * i), 630 + 330, gameSpeed, 0));
  }
}

//set up food objects
void createFood() {
  for (int i = 0; i < 10; i++) {
    int randomY = (int) random(0, 4);

    //distribute food objects between 4 conveyor belts randomly
    int prevRandomY = randomY;
    if (prevRandomY == randomY) {
      randomY = (int) random(0, 4);
    }

    foods.add(new Food(width + 65 + (i * 140 * (int)random(1, 3)), 625 + (randomY * 110), gameSpeed, 0));
  }
}


/*======================
 UPDATE OBJECTS
 ========================*/
void updateButtons() {
  for (int i = 0; i < buttons.size(); i++) {
    Buttons b = buttons.get(i);
    b.update();

    //draw arrows on buttons based on order of arraylist
    if (i == 0) {
      image(upArrow, b.pos.x + 35, 624);
    }
    if (i == 1) {
      image(leftArrow, b.pos.x + 32, 734);
    }
    if (i == 2) {
      image(rightArrow, b.pos.x + 35, 844);
    }
    if (i == 3) {
      image(downArrow, b.pos.x + 35, 955);
    }
  }
}


void updateBgChefs() {
  for (int i = 0; i < bgChefs.size(); i++) { 
    Chef backgroundChefs = bgChefs.get(i);
    backgroundChefs.render();
  }
}

void updateConveyorBelt() {
  for (int i = 0; i < cBelt.size(); i++) {
    ConveyorBelt cb = cBelt.get(i);
    cb.update();
  }
}

void animateLines() {
  for (int i = 0; i<cbLines.size(); i++) {                                       //animate movement
    ConveyorBeltLines cbL = cbLines.get(i);
    cbL.update();
  }
}

void updateFood() {
  for (int i = 0; i<foods.size(); i++) {                                       //animate movement
    Food foodItem = foods.get(i);
    foodItem.update();

    if (foodItem.pos.x < -100) {
      foods.remove(i);
      score.updateScore(-20); //decrease score if food is missed
      comboCounter = 1;
    }

    //add food items to array list if number drops below 10
    if (foods.size() < 10) {
      int randomY = (int) random(0, 4);
      foods.add(new Food(width + 65 + (i * 140 * (int)random(1, 3)), 625 + (randomY * 110), gameSpeed, 0));
    }
  }
}

//check if button is pressed once food passes over it
void checkButtonCollision() {
  for (int i = 0; i < buttons.size(); i++) {
    Buttons b = buttons.get(i);

    for (int f = 0; f<foods.size(); f++) {                                       //animate movement
      Food foodItem = foods.get(f);

      //increase score if food is hit and remove food object
      if (foodItem.hitObject(b) == true && i == 0 && up == true) {
        comboCounter += 1;
        score.updateScore(20*comboCounter); 
        foods.remove(f);
      } else if (foodItem.hitObject(b) == true && i == 1 && left == true) {
        comboCounter += 1;
        score.updateScore(20*comboCounter);
        foods.remove(f);
      } else if (foodItem.hitObject(b) == true && i == 2 && right == true) {
        comboCounter += 1;
        score.updateScore(20*comboCounter);
        foods.remove(f);
      } else if (foodItem.hitObject(b) == true && i == 3 && down == true) {
        comboCounter += 1;
        score.updateScore(20*comboCounter); 
        foods.remove(f);
      }
    }
  }
}

//draw combo score
void comboScore() {
  pushStyle();
  fill(0);
  if (comboCounter >= 1) {
    text("Combo: x" + comboCounter, 1600, 75);    //sub title
  }
  popStyle();
}

/*======================
 LOAD ASSETS
 =======================*/

void loadAssets() {
  homeBg = loadImage("home-background.png");
  gameBg = loadImage("game-background.jpg");
  homeBg = loadImage("home-background.jpg");
  helpMenu = loadImage("help-menu-buttons.png");
  cashScore = loadImage("cash-bill.jpg");
  chefSprite = loadImage("chef-sprite.png");
  upArrow = loadImage("data/img/UpArrow.png");
  downArrow = loadImage("data/img/DownArrow.png");
  leftArrow = loadImage("data/img/LeftArrow.png");
  rightArrow = loadImage("data/img/RightArrow.png");

  player = new Player(width/2, height/2.75, 0, 0, 1.5);

  score = new Score();

  PFont gameFont = loadFont("LoRes12OT-BoldAltOakland-48.vlw");
  textFont(gameFont, 48);
  createBgChefs();
  createConveyorBelt();
  createButtons();
  setUpLines();
  createFood();

  m = new Minim(this);
  homeBGM = m.loadFile(HOME_BGM);
  song1 = m.loadFile(SONG1);
  song2 = m.loadFile(SONG2);
  endBGM = m.loadFile(END_BGM);
}

/*======================
 Game UI
 ========================*/

void updateGameUI() {
  song1Timer --;
  imageMode(CORNER);
  image(gameBg, 0, 0);
  image(cashScore, 60, 30);
  score.render();
  updateConveyorBelt();
  animateLines();
  updateButtons();
  updateBgChefs();
  player.update();
  updateFood();
  comboScore();

  //end gameplay once song is over
  if (song1Timer <= 0) {
    gameState = END_SCREEN_STATE; 
    playBGM(END_BGM);
  }

  //windows laptop
  //stop sending food once song reaches a certain point
  if (song1Timer <= 550) {
    gameSpeed = 0;
  }

  //pause song once it is over
  if (song1Timer <= 50) {
    song2.pause();
  }

  /*
  //mac
   //stop sending food once song reaches a certain point
   if (song1Timer <= 250) {
   gameSpeed = 0;  
   }
   
   //pause song once it is over
   if (song1Timer <= 230) {
   song2.pause();
   }*/
}

/*======================
 SOUND/MUSIC SETTINGS
 ========================*/
void playBGM (String file) {
  AudioPlayer sound = null;

  //play different song tracks based on which string is accessed
  if (file == HOME_BGM) {
    sound = homeBGM;
  } else if (file == SONG1) {
    sound = song1;
  } else if (file == SONG2) {
    sound = song2;
  } else if (file == END_BGM) {
    sound = endBGM;
  }


  sound.rewind();
  sound.play();
  sound.loop();
}

//adjust volume of game based on potentiometer
void volumeControl() {
  int volumeValue;

  //set volume value
  if (sliderSensorValue <= 0) {
    volumeValue = 30
      ;
  } else if (sliderSensorValue <= 50) {
    volumeValue = 20;
  } else if (sliderSensorValue <= 100) {
    volumeValue = 0;
  } else if (sliderSensorValue <= 150) {
    volumeValue = -10;
  } else if (sliderSensorValue <= 200) {
    volumeValue = -20;
  } else if (sliderSensorValue <= 255) {
    volumeValue = -100;
  } else {
    volumeValue = 0;          //set volume default volume
  }

  //adjust volume value of songs
  homeBGM.setGain(volumeValue);
  song1.setGain(volumeValue);
  song2.setGain(volumeValue);
  endBGM.setGain(volumeValue);
}

/*======================
 CONTROLS
 ========================*/
//keyboard controls used for testing
void keyPressed() {
  if (key == 'a' || key == 'A') {
    left = true;
    println("left is " + left);
    if (gameState == GAMEPLAY_SCREEN_STATE) {
      checkButtonCollision();
      score.updateScore(-10);
    }
  } else if (key == 's' || key == 'S') {
    down = true;
    println("down is " + down);
    if (gameState == GAMEPLAY_SCREEN_STATE) {
      checkButtonCollision();
      score.updateScore(-10);
    }
  } else if (key == 'w' || key == 'W') {
    up = true;
    println("up is " + up);
    if (gameState == GAMEPLAY_SCREEN_STATE) {
      checkButtonCollision();
      score.updateScore(-10);
    }
  } else if (key == 'd' || key == 'D') {
    right = true;
    println("right is " + right);
    if (gameState == GAMEPLAY_SCREEN_STATE) {
      checkButtonCollision();
      score.updateScore(-10);
    }
  }
}


void keyReleased() {
  left = false;
  down = false;
  up = false;
  right = false;
}

//check input of touch sensors and switch
void touchInput() {
  //touch sensor cases
  if (touchSensorValue == 8) {
    left = true;
    checkButtonCollision();
  } else if (touchSensorValue == 9) {
    down = true;
    checkButtonCollision();
  } else if (touchSensorValue == 10) {
    up = true;
    checkButtonCollision();
  } else if (touchSensorValue == 11) {
    right = true;
    println("right");
    checkButtonCollision();
  } else if (touchSensorValue == 13) {
    left = false;
    down = false;
    up = false;
    right = false;
    checkButtonCollision();
  }

  //button switch cases   
  if (buttonValue == 0 && gameState == HELP_SCREEN_STATE) { 
    buttonCheck = true;
  } 
  if (buttonValue == 0 && gameState == HOME_SCREEN_STATE) { 
    buttonEndCheck = true;
  } 

  if (buttonValue == 1 && buttonEndCheck == true && gameState == HOME_SCREEN_STATE) { 
    gameState = HELP_SCREEN_STATE;
  } else if (buttonValue == 1 && buttonCheck == true && gameState == HELP_SCREEN_STATE) { 
    gameState = GAMEPLAY_SCREEN_STATE; 
    homeBGM.pause();
    playBGM(SONG2);
  } else if (buttonValue == 1 && gameState == END_SCREEN_STATE) {
    gameState = HOME_SCREEN_STATE;  
    buttonCheck = false;
    buttonEndCheck = false;
    endBGM.pause();
    playBGM(HOME_BGM);
  }
} 
