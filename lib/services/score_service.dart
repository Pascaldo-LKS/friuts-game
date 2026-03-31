
class ScoreService {
  int _score = 0;

  int get currentScore => _score;

  // Bonne réponse → +5
  void addCorrect() {
    _score += 5;
  }

  // Mauvaise réponse → -2
  void addWrong() {
    _score -= 2;
  }

  void resetScore() {
    _score = 0;
  }
}