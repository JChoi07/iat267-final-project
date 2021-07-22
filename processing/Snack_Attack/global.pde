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
ArrayList<Buttons> buttons = new ArrayList<Buttons>();
ArrayList<ConveyorBelt> cBelt = new ArrayList<ConveyorBelt>();
ArrayList<ConveyorBeltLines> cbLines = new ArrayList<ConveyorBeltLines>();
ConveyorBeltLines line;
//Buttons button;

void loadAssets() {
  gameBg = loadImage("game-background.jpg");
  chefSprite = loadImage("chef-sprite.png");
  cashScore = loadImage("cash-bill.jpg");

  score = new Score();

  PFont gameFont = loadFont("LoRes12OT-BoldAltOakland-48.vlw");
  textFont(gameFont, 48);
  createBgChefs();
  createConveyorBelt();
  createButtons();
  setUpLines();
}

void createButtons() {
  //button = new Buttons(-5, 620, 0, 0);
  for (int i = 0; i < 4; i++) {
    buttons.add(new Buttons(-5, 620 + (i*110), 0, 0));
  }
}

void updateButtons(){
  for (int i = 0; i < buttons.size(); i++)  {
    Buttons b = buttons.get(i);
    b.update();
  }
}

void createConveyorBelt() {
  for (int i = 0; i < 4; i++) {
    cBelt.add(new ConveyorBelt(0, 630 + (i*110), 0, 0));
  }
}

void updateConveyorBelt() {
  for (int i = 0; i < cBelt.size(); i++)  {
    ConveyorBelt cb = cBelt.get(i);
    cb.update();
    
  }
}

  void setUpLines() {
    for(int i = 0; i<19; i++){                                                  //set up conveyor belt lines for every belt
      cbLines.add(new ConveyorBeltLines(0 + (100 * i), 630, gameSpeed, 0));
      cbLines.add(new ConveyorBeltLines(0 + (100 * i), 630 + 110, gameSpeed, 0));
      cbLines.add(new ConveyorBeltLines(0 + (100 * i), 630 + 220, gameSpeed, 0));
      cbLines.add(new ConveyorBeltLines(0 + (100 * i), 630 + 330, gameSpeed, 0));
   }
  }

  void animateLines() {
   for(int i = 0; i<cbLines.size(); i++){                                       //animate movement
     ConveyorBeltLines cbL = cbLines.get(i);
     cbL.update();
   }
  }


void createBgChefs() {
  for (int i = 0; i < 2; i++) {
    Chef smallChef = new Chef(100, 100, 0, 0);
    bgChefs.add(smallChef);
  }
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

void run() {
  x = (counter % 6) * w;
  y = 201;
  copy(chefSprite, x, y, w, w, 0, 0, w, w);
  counter = counter + 1;
}

void fly() {
  x = (counter % 6) * w;
  y = 401;
  copy(chefSprite, x, y, w, w, 0, 0, w, w);
  counter = counter + 1;
}

void punch() {
  x = (counter % 3) * w;
  y = 600;
  copy(chefSprite, x, y, w, w, 0, 0, w, w);
  counter = counter + 1;
}

void death() {
  x = (counter % 2) * w;
  y = 800;
  copy(chefSprite, x, y, w, w, 0, 0, w, w);
  counter = counter + 1;
}

void victory() {
  x = 2*w;
  y = 801;
  copy(chefSprite, x, y, w, w, 0, 0, w, w);
  counter = counter + 1;
}


/*======================
 GAME STATES
 =======================*/

void displayGameUI() {
  image(gameBg, 0, 0);
  image(cashScore, 60, 30);
  createBgChefs();
  score.render();
  createConveyorBelt();
  createButtons();
  setUpLines();
}

void gameStart() {
  image(gameBg, 0, 0);
  image(cashScore, 60, 30);
  //displayGameUI();
  standBy();
  updateConveyorBelt();
  animateLines();
  updateButtons();
  score.render();
  //punch();
  //fly();
  //run();
  //death();
  //victory();
}

void homeScreen() {
}

void gameOver() {
  text(score.score, width/2, height/2);
}


void gameplay() {
  for (Chef bgChefs : bgChefs) {
    bgChefs.render();
  }
}
