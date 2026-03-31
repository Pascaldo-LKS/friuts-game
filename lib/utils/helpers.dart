import 'dart:math';

class Helpers {
  // Mélanger une liste
  static List<T> shuffleList<T>(List<T> list) {
    final random = Random();
    for (int i = list.length - 1; i > 0; i--) {
      int j = random.nextInt(i + 1);
      T temp = list[i];
      list[i] = list[j];
      list[j] = temp;
    }
    return list;
  }

  // Générer un nombre aléatoire
  static int randomIndex(int max) {
    final random = Random();
    return random.nextInt(max);
  }
}