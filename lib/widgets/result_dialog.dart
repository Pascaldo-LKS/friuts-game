import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class ResultDialog extends StatefulWidget {
  final int score;
  final bool won;

  const ResultDialog({required this.score, required this.won});

  @override
  _ResultDialogState createState() => _ResultDialogState();
}

class _ResultDialogState extends State<ResultDialog> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();

    _confettiController = ConfettiController(duration: Duration(seconds: 2));

    if (widget.won) {
      _confettiController.play();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 🎆 CONFETTI
            if (widget.won)
              Positioned(
                top: 0,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  numberOfParticles: 30,
                  maxBlastForce: 20,
                  minBlastForce: 5,
                  emissionFrequency: 0.05,
                  gravity: 0.3,
                ),
              ),

            // 💎 POPUP
            AnimatedContainer(
              duration: Duration(milliseconds: 400),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🎯 Emoji
                  Text(widget.won ? "🎉" : "❌", style: TextStyle(fontSize: 50)),

                  SizedBox(height: 10),

                  // 📝 Message
                  Text(
                    widget.won ? "Victoire !" : "Défaite",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: widget.won ? Colors.green : Colors.red,
                    ),
                  ),

                  SizedBox(height: 10),

                  // 🏆 Score
                  Text(
                    "Score : ${widget.score}",
                    style: TextStyle(fontSize: 18),
                  ),

                  SizedBox(height: 20),

                  // 🎮 Boutons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // 🔁 Rejouer
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/game');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text('Rejouer'),
                      ),

                      // 🏠 Accueil
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text('Accueil'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
