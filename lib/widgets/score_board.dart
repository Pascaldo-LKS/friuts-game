import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final int score;

  ScoreBoard({required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.green[100], // couleur douce pour le score
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Score : $score',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green[900],
            ),
          ),
        ],
      ),
    );
  }
}