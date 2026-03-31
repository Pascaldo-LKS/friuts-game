import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  final int timeLeft;

  TimerWidget({required this.timeLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.orange[100], // couleur pour le timer
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.timer, color: Colors.orange[900]),
          Text(
            '$timeLeft s',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.orange[900],
            ),
          ),
        ],
      ),
    );
  }
}