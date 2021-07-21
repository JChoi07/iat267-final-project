class Score {
  int score;
  PFont scoreFont;
  color scoreColor;

  void render() {
    fill(0);
    textSize(36);
    text("$" + score, 180, 75);
  }

  void updateScore(int increment) {
    score =+ increment;
  }
}
