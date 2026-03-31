import 'package:flutter/material.dart';

class AppConstants {
  // Couleurs principales
  static const Color primaryColor = Colors.green;
  static const Color secondaryColor = Colors.orange;

  // Durée du timer (en secondes)
  static const int initialTime = 5;

  // Score minimum pour gagner
  static const int winningScore = 10;

  // Textes du jeu
  static const String gameTitle = 'Jeu des Fruits 🍎';
  static const String winMessage = '🎉 Bravo ! Tu as gagné !';
  static const String loseMessage = '❌ Perdu ! Essaie encore';
}