class Score {
  int score;
  PFont scoreFont;
  color scoreColor;


  void updateScore(int increment) {
    score += increment;
  }
  
  void render() {
    pushStyle();
    fill(0);
    textSize(36);
    text("$" + score, 180, 75);
    popStyle();
  }
}
