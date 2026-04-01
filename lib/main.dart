import 'package:flutter/material.dart';

// Importation des écrans (screens)
import 'screens/home_screen.dart';
import 'screens/game_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/about_screen.dart';

void main() {
  // Point d’entrée de l’application
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Ce widget représente toute l'application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Supprime le petit bandeau "debug" en haut à droite
      debugShowCheckedModeBanner: false,

      // Titre de l'application
      title: 'Jeu des Fruits 🍎',

      // Thème global de l'application (couleurs, style)
      theme: ThemeData(
        primarySwatch: Colors.green, // couleur principale
        scaffoldBackgroundColor: const Color.fromARGB(
          255,
          208,
          192,
          192,
        ), // fond blanc
      ),

      // Page affichée au démarrage
      //home: HomeScreen(),
      home: SplashScreen(),

      // Gestion des routes (navigation entre les pages)
      routes: {
        '/home': (context) => HomeScreen(),
        '/game': (context) => GameScreen(),

        '/settings': (context) => SettingsScreen(),
        '/about': (context) => AboutScreen(),
      },
    );
  }
}
