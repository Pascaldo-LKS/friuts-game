import 'dart:math';
import '../models/fruit_model.dart';

class GameLogic {
  final List<FruitModel> allFruits = [
    FruitModel(name: 'Pomme', imagePath: 'assets/images/apple.png'),
    FruitModel(name: 'Banane', imagePath: 'assets/images/banana.png'),
    FruitModel(name: 'Orange', imagePath: 'assets/images/orange.jpg'),
    FruitModel(name: 'Fraise', imagePath: 'assets/images/strawberry.jpg'),
    FruitModel(name: 'Raisin', imagePath: 'assets/images/grape.jpg'),
    FruitModel(name: 'Ananas', imagePath: 'assets/images/pineapple.jpg'),
    FruitModel(name: 'Mangue', imagePath: 'assets/images/mango.jpg'),
    FruitModel(name: 'Cerise', imagePath: 'assets/images/cherry.png'),
    FruitModel(name: 'Pastèque', imagePath: 'assets/images/watermelon.png'),
  ];

  final Random random = Random();

  // Génère une liste de 9 fruits aléatoires
  List<FruitModel> generateFruits() {
    allFruits.shuffle();
    return allFruits.take(9).toList();
  }

  // Sélectionne le fruit cible parmi les 9
  FruitModel selectTargetFruit(List<FruitModel> fruits) {
    int index = random.nextInt(fruits.length);
    FruitModel target = fruits[index].copyWith(isTarget: true);
    fruits[index] = target;
    return target;
  }

  // Vérifie si le fruit tapé est correct
  bool checkFruit(FruitModel tapped, FruitModel target) {
    return tapped.name == target.name;
  }
}