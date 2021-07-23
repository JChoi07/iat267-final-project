PImage gameBg, cashScore;
int gameState=1;
int gameSpeed = -3;
int startPage=0;
int gameUI=1;
int w=200;
int counter = 0;
int x, y;
PImage chefSprite;
Score score;

ArrayList<Chef> bgChefs = new ArrayList<Chef>();
Player player;
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
  for (int i = 0; i < 4; i++) {
    cBelt.add(new ConveyorBelt(0, 630 + (i*110), 0, 0));
  }
}

void createBgChefs() {
  for (int i = 0; i < 1; i++) {
    bgChefs.add(new Chef(1650, 380, 0, 0, .7));
    bgChefs.add(new Chef(370, 420, 0, 0, .7));
  }
}

void setUpLines() {
  for (int i = 0; i<19; i++) {                                                  //set up conveyor belt lines for every belt
    cbLines.add(new ConveyorBeltLines(50 + (100 * i), 630, gameSpeed, 0));
    cbLines.add(new ConveyorBeltLines(50 + (100 * i), 630 + 110, gameSpeed, 0));
    cbLines.add(new ConveyorBeltLines(50 + (100 * i), 630 + 220, gameSpeed, 0));
    cbLines.add(new ConveyorBeltLines(50 + (100 * i), 630 + 330, gameSpeed, 0));
  }
}

/*======================
 UPDATE OBJECTS
 ========================*/

void updateButtons() {
  for (int i = 0; i < buttons.size(); i++) {
    Buttons b = buttons.get(i);
    b.update();
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

/*======================
 LOAD ASSETS
 =======================*/

void loadAssets() {
  gameBg = loadImage("game-background.jpg");
  cashScore = loadImage("cash-bill.jpg");
  chefSprite = loadImage("chef-sprite.png");

  player = new Player(width/2, height/2, 0, 0, 1);

  score = new Score();

  PFont gameFont = loadFont("LoRes12OT-BoldAltOakland-48.vlw");
  textFont(gameFont, 48);
  createBgChefs();
  createConveyorBelt();
  createButtons();
  setUpLines();
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
