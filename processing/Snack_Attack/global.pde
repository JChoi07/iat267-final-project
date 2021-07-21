PImage gameBg, cashScore;
int gameState=1;
int startPage=0;
int gameUI=1;
int w=200;
int counter = 0;
int x, y;
int score;
PImage chefSprite;

ArrayList<Chef> bgChefs = new ArrayList<Chef>();

void loadAssets() {
  gameBg = loadImage("game-background.jpg");
  chefSprite = loadImage("chef-sprite.png");
  cashScore = loadImage("cash-bill.jpg");

  PFont gameFont = loadFont("LoRes12OT-BoldAltOakland-48.vlw");
  textFont(gameFont, 48);
  //textAlign(CENTER);
}

void createBgChefs() {
  for (int i = 0; i < 2; i++) {
    Chef smallChef = new Chef(100, 100, 0, 0);
    bgChefs.add(smallChef);
  }
}

void updateScore() {
  fill(0);
  textSize(36);
  text("$" + score, 180, 75);
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
  updateScore();
}

void gameStart() {
  displayGameUI();
  standBy();
  //punch();
  //fly();
  //run();
  //death();
  //victory();
}

void gameOver() {
}

void homeScreen() {
}

void gameplay() {
  for (Chef bgChefs : bgChefs) {
    bgChefs.render();
  }
}
