//Initialize global variables
PImage gameBg, homeBg, cashScore, upArrow, downArrow, leftArrow, rightArrow;
boolean up, right, left, down;
int gameState;
int gameSpeed = -5;
int startPage=0;
int gameUI=1;
int w=200;
int counter = 0;
int x, y;
int blink = 255;
int blinkSpeed = 20;
int shakeX, shakeY;
PImage chefSprite;
Score score;
Char character;

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
final String SONG1 = ("music/club-penguin-pizza-parlor.mp3");
final String SONG2 = ("music/Stardust Speedway Zone Act 1 - Sonic Mania [OST].mp3");
AudioPlayer song1, song2;


//Initialize classes and arrays
ArrayList<Chef> bgChefs = new ArrayList<Chef>();
Player player;
ArrayList<Food> foods = new ArrayList<Food>();
ArrayList<Buttons> buttons = new ArrayList<Buttons>();
ArrayList<ConveyorBelt> cBelt = new ArrayList<ConveyorBelt>();
ArrayList<ConveyorBeltLines> cbLines = new ArrayList<ConveyorBeltLines>();
ConveyorBeltLines line;
//Buttons button;

/*======================
 GAME STATES
 =======================*/

void gameStart() {
  updateGameUI();
  player.render();
}

void homeScreen() {
  image(homeBg, 0, 0);

  updateBgChefs();
  strokeWeight(0);
  fill(0, 0, 0, 120);
  rect(0, 0, width, height);

  textAlign(CENTER);
  fill(255, 255, 255);
  textSize(120);
  text("SNACK ATTACK", width/2 + shakeX, height/1.85 - shakeY);

  shakeX += random(-1.5, 1.5);
  shakeY += random(-1.5, 1.5);

  fill(255, 255, 255, blink);
  textSize(48);
  text("Press Switch to Start", width/2, height/1.55);

  //fill(100, 5, 252);
  //strokeWeight(2);
  //rectMode(CENTER);
  //rect(width/2, height/1.3, 200, 60, 5);

  //strokeWeight(0);
  //fill(255, 255, 255, 200);
  //rect(width/2 + 92, height/1.3 - 14, 4, 14);
  //rect(width/2 + 92, height/1.3 + 4, 4, 4);
  //rectMode(CORNER);

  //textSize(30);
  //fill(255, 255, 255, blink);
  //text("HELP", width/2, height/1.28);

  textAlign(LEFT);
  textSize(16);
  fill(255, 255, 255);
  text("Jonathan Choi", 20, height - 45);
  text("David Baik", 20, height - 25);

  //textAlign(RIGHT);
  text("IAT 267", 20, 35);

  blink += blinkSpeed;

  if (blink > 255 || blink < 0) {
    blinkSpeed *= -1;
  }

  if (keyPressed && key == 'o') {
    gameState = -1;
  }
}

void helpScreen() {
  background(255);
  rectMode(CORNER);
  strokeWeight(0);
  fill(0, 0, 0, 120);
  rect(0, 0, width, height);
  updateButtons();
}

void gameOver() {
  text(score.score, width/2, height/2);
}

/*=================================
 ARDUINO + PROCESSING INTERACTIONS
 ==================================*/
/*
void createSerialConnection() {
 println("Available serial ports:");
 println(Serial.list());
 
 //port = new Serial(this, "COM3", 9600); 
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
void createButtons() {
  //button = new Buttons(-5, 620, 0, 0);
  for (int i = 0; i < 4; i++) {
    buttons.add(new Buttons(-5, 620 + (i*110), 0, 0));
  }
}

void createConveyorBelt() {
  for (int i = 0; i < 1; i++) {
    cBelt.add(new ConveyorBelt(138, upBelt, 0, 0));
    cBelt.add(new ConveyorBelt(138, rightBelt, 0, 0));
    cBelt.add(new ConveyorBelt(138, leftBelt, 0, 0));
    cBelt.add(new ConveyorBelt(138, downBelt, 0, 0));
  }
}

void createBgChefs() {
  for (int i = 0; i < 1; i++) {
    bgChefs.add(new Chef(370, 490, -5, 0, .7));
    bgChefs.add(new Chef(1500, 510, 5, 0, .7));
  }
}

void setUpLines() {
  for (int i = 0; i<14; i++) {                                                  //set up conveyor belt lines for every belt
    cbLines.add(new ConveyorBeltLines(280 + (140 * i), 630, gameSpeed, 0));
    cbLines.add(new ConveyorBeltLines(280 + (140 * i), 630 + 110, gameSpeed, 0));
    cbLines.add(new ConveyorBeltLines(280 + (140 * i), 630 + 220, gameSpeed, 0));
    cbLines.add(new ConveyorBeltLines(280 + (140 * i), 630 + 330, gameSpeed, 0));
  }
}

void createFood() {
  for (int i = 0; i < 10; i++) {
    int randomY = (int) random(0, 4);

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

    if (foods.size() < 10) {
      int randomY = (int) random(0, 4);
      foods.add(new Food(width + 65 + (i * 140 * (int)random(1, 3)), 625 + (randomY * 110), gameSpeed, 0));
    }
  }
}

void checkButtonCollision() {
  for (int i = 0; i < buttons.size(); i++) {
    Buttons b = buttons.get(i);

    for (int f = 0; f<foods.size(); f++) {                                       //animate movement
      Food foodItem = foods.get(f);

      //increase score if food is hit
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

      ////decrease score if food is missed
      //if (foodItem.hitObject(b) == false && i == 0 && up == true) {
      //  comboCounter = 0; 
      //}
      //else if (foodItem.hitObject(b) == false && i == 1 && left == true) {
      //  score.updateScore(-20);
      //}
      //else if (foodItem.hitObject(b) == false && i == 2 && right == true) {
      //  score.updateScore(-20);
      //}
      //else if (foodItem.hitObject(b) == false && i == 3 && down == true) {
      //  score.updateScore(-20); 
      //}
    }
  }
}

void checkConveyorBeltCollision() {
  for (int i = 0; i < cBelt.size(); i++) {
    ConveyorBelt cb = cBelt.get(i);

    for (int f = 0; f<foods.size(); f++) {                                       //animate movement
      Food foodItem = foods.get(f);

      //increase score if food is hit
      if (foodItem.hitObject(cb) == true && i == 0 && up == true) {
        comboCounter = 1;
        score.updateScore(-20); 
        println("hit");
      } else if (foodItem.hitObject(cb) == true && i == 1 && left == true) {
        comboCounter = 1;
        score.updateScore(-20);
      } else if (foodItem.hitObject(cb) == true && i == 2 && right == true) {
        comboCounter = 1;
        score.updateScore(-20);
      } else if (foodItem.hitObject(cb) == true && i == 3 && down == true) {
        comboCounter = 1;
        score.updateScore(-20);
      }
    }
  }
}

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
  gameBg = loadImage("game-background.jpg");
  homeBg = loadImage("home-background.jpg");
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
  song1 = m.loadFile(SONG1);
  song2 = m.loadFile(SONG2);
}

/*======================
 Game UI
 ========================*/

void updateGameUI() {
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
  //songPlayer();
  //song1Play();
  //standBy();
}

/*======================
 CHEF STATES
 ========================*/
void standBy() {
  x = (counter % 4) * w;
  y = 0;

  pushMatrix();
  translate(370, 420);
  scale(.7);
  copy(chefSprite, x, y, w, w, 0, 0, w, w);
  popMatrix();

  if (frameCount % 6 == 0) {
    counter = counter + 1;
  }

  pushMatrix();
  translate(1650, 380);
  scale(-.7, .7);
  copy(chefSprite, x, y, w, w, 0, 0, w, w);
  popMatrix();
}


/*======================
 SOUND/MUSIC SETTINGS
 ========================*/
void playBGM (String file) {
  AudioPlayer sound = null;

  if (file == SONG1) {
    sound = song1;
  } else if (file == SONG2) {
    sound = song2;
  }

  sound.rewind();
  sound.play();
  sound.loop();
}

void volumeControl() {
  int volumeValue;

  if (sliderSensorValue <= 0) {
    volumeValue = -100
      ;
  } else if (sliderSensorValue <= 50) {
    volumeValue = -10;
  } else if (sliderSensorValue <= 100) {
    volumeValue = 0;
  } else if (sliderSensorValue <= 150) {
    volumeValue = 10;
  } else if (sliderSensorValue <= 200) {
    volumeValue = 20;
  } else if (sliderSensorValue <= 255) {
    volumeValue = 30;
  } else {
    volumeValue = 0;          //set volume default volume
  }

  song1.setGain(volumeValue);
  song2.setGain(volumeValue);
}

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
  if (buttonValue == 0) {
    //do nothing
  } else if (buttonValue == 1) {
    //confirm action
  }
}


/*======================
 CONTROLS
 ========================*/
void keyPressed() {
  if (key == 'a' || key == 'A') {
    left = true;
    println("left is " + left);
    if (gameState == GAMEPLAY_SCREEN_STATE) {
      checkButtonCollision();
      //checkConveyorBeltCollision();
      score.updateScore(-10);
    }
    //gameState = GAMEPLAY_SCREEN_STATE;
    //song2.pause();
    //playBGM(SONG1);
  } else if (key == 's' || key == 'S') {
    down = true;
    println("down is " + down);
    if (gameState == GAMEPLAY_SCREEN_STATE) {
      checkButtonCollision();
      //checkConveyorBeltCollision();
      score.updateScore(-10);
    }
  } else if (key == 'w' || key == 'W') {
    up = true;
    println("up is " + up);
    if (gameState == GAMEPLAY_SCREEN_STATE) {
      checkButtonCollision();
      //checkConveyorBeltCollision();
      score.updateScore(-10);
    }
  } else if (key == 'd' || key == 'D') {
    right = true;
    println("right is " + right);
    if (gameState == GAMEPLAY_SCREEN_STATE) {
      checkButtonCollision();
      //checkConveyorBeltCollision();
      score.updateScore(-10);
    }
    //gameState = HOME_SCREEN_STATE;
    //song1.pause();
    //playBGM(SONG2);
  }
}


void keyReleased() {
  left = false;
  down = false;
  up = false;
  right = false;
}
