//Initialize global variables
PImage gameBg, cashScore, upArrow, downArrow, leftArrow, rightArrow;
boolean up, right, left, down;
int gameState=1;
int gameSpeed = -5;
int startPage=0;
int gameUI=1;
int w=200;
int counter = 0;
int x, y;
int value = -20;
PImage chefSprite;
Score score;
Char character;

int upBelt = 630;
int rightBelt = 740;
int leftBelt = 850;
int downBelt = 960;

//Initialize sounds/minim
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
Minim m;

final String SONG1 = ("music/club-penguin-pizza-parlor2.mp3");
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
  score.render();
  player.render();
}

void homeScreen() {
}

void gameOver() {
  text(score.score, width/2, height/2);
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
    cBelt.add(new ConveyorBelt(0, upBelt, 0, 0));
    cBelt.add(new ConveyorBelt(0, rightBelt, 0, 0));
    cBelt.add(new ConveyorBelt(0, leftBelt, 0, 0));
    cBelt.add(new ConveyorBelt(0, downBelt, 0, 0));
  }
}

void createBgChefs() {
  for (int i = 0; i < 1; i++) {
    bgChefs.add(new Chef(1650, 380, 0, 0, .7));
    bgChefs.add(new Chef(370, 420, 0, 0, .7));
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
void updateButtons(){
  for (int i = 0; i < buttons.size(); i++)  {
    Buttons b = buttons.get(i);
    b.update();
    
    //draw arrows on buttons based on order of arraylist
    if (i == 0)  {
       image(upArrow, b.pos.x + 35, 624);
    }
    if (i == 1)  {
       image(leftArrow, b.pos.x + 32, 734);
    }
    if (i == 2)  {
       image(rightArrow, b.pos.x + 35, 844);
    }
    if (i == 3)  {
       image(downArrow, b.pos.x + 35, 955);
    }
  }
}


void updateBgChefs() {
  for (int i = 0; i < bgChefs.size(); i++) { 
    Chef backgroundChefs = bgChefs.get(i);
    backgroundChefs.update();
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
    }

    if (foods.size() < 10) {
      int randomY = (int) random(0, 4);
      foods.add(new Food(width + 65 + (i * 140 * (int)random(1, 3)), 625 + (randomY * 110), gameSpeed, 0));
    }
  }
}

/*======================
 LOAD ASSETS
 =======================*/

void loadAssets() {
  gameBg = loadImage("game-background.jpg");
  cashScore = loadImage("cash-bill.jpg");
  chefSprite = loadImage("chef-sprite.png");
  upArrow = loadImage("data/img/UpArrow.png");
  downArrow = loadImage("data/img/DownArrow.png");
  leftArrow = loadImage("data/img/LeftArrow.png");
  rightArrow = loadImage("data/img/RightArrow.png");

  player = new Player(width/2, height/2, 0, 0, 1);
  character = new Char(width/2, height/2, 0, 0);

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
  image(gameBg, 0, 0);
  image(cashScore, 60, 30);
  score.render();
  updateConveyorBelt();
  animateLines();
  updateButtons();
  updateBgChefs();
  player.update();
  character.update();
  updateFood();
  volume();
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

void volume() {
  song1.setGain(value);
  song2.setGain(value);
}
  
  
  
/*======================
 CONTROLS
 ========================*/
void keyPressed() {
    if (key == 'a' || key == 'A') {
      left = true;
      println("left is " + left);
      gameState = GAMEPLAY_SCREEN_STATE;
      song2.pause();
      playBGM(SONG1);
    } else if (key == 's' || key == 'S') {
      down = true;
      value -= 1;
      println("right is " + down);
    } else if (key == 'w' || key == 'W') {
      up = true;
      println("up is " + up);
      value += 1;
    } else if (key == 'd' || key == 'D') {
      right = true;
      println("right is " + right);
      gameState = HOME_SCREEN_STATE;
      song1.pause();
      playBGM(SONG2);
    }
  }

  void keyReleased() {
    left = false;
    down = false;
    up = false;
    right = false;
  }
  

//void death() {
//  x = (counter % 2) * w;
//  y = 800;
//  copy(chefSprite, x, y, w, w, 0, 0, w, w);
//  counter = counter + 1;
//}

//void victory() {
//  x = 2*w;
//  y = 801;
//  copy(chefSprite, x, y, w, w, 0, 0, w, w);
//  counter = counter + 1;
//}