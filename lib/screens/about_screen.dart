import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('À propos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jeu des Fruits 🍎',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Projet réalisé par le groupe :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '- Étudiant 1\n- Étudiant 2\n- Étudiant 3',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Technologies utilisées : Flutter, Dart\nVersion : 1.0.0',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Description :\nCe jeu permet de trouver le bon fruit parmi 9 fruits affichés sur l’écran. Le joueur doit être rapide et attentif.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}