import 'package:flutter/material.dart';
import '../models/fruit_model.dart';
import '../widgets/fruit_card.dart';
import '../widgets/score_board.dart';
import '../widgets/timer_widget.dart';
import '../widgets/result_dialog.dart';

import '../services/game_logic.dart';
import '../services/score_service.dart';
import '../services/sound_service.dart';
import '../services/settings_service.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  List<FruitModel> fruits = [];
  late FruitModel targetFruit;

  int score = 0;
  int timeLeft = 5;

  bool isGameOver = false;

  GameLogic gameLogic = GameLogic();
  ScoreService scoreService = ScoreService();

  // 🎬 Animation
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    scoreService.resetScore();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    startNewRound();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 🎮 Nouvelle manche
  void startNewRound() {
    if (isGameOver) return;

    fruits = gameLogic.generateFruits();
    targetFruit = gameLogic.selectTargetFruit(fruits);

    // 🎯 Difficulté
    switch (SettingsService.difficulty) {
      case 'Facile':
        timeLeft = 5;
        break;
      case 'Moyen':
        timeLeft = 4;
        break;
      case 'Difficile':
        timeLeft = 3;
        break;
    }

    _controller.forward(from: 0);
    startTimer();

    setState(() {});
  }

  // ⏱️ Timer
  void startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (!mounted || isGameOver) return;

      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
        startTimer();
      } else {
        SoundService.playError();

        scoreService.addWrong();
        score = scoreService.currentScore;

        showResult();
      }
    });
  }

  // 🎯 Clic sur fruit
  void handleFruitTap(FruitModel fruit) {
    if (isGameOver) return;

    SoundService.playClick();

    bool correct = gameLogic.checkFruit(fruit, targetFruit);

    if (correct) {
      SoundService.playSuccess();

      scoreService.addCorrect();
      score = scoreService.currentScore;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('✅ +5 points')));

      startNewRound();
    } else {
      SoundService.playError();

      scoreService.addWrong();
      score = scoreService.currentScore;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('❌ -2 points')));

      showResult();
    }
  }

  // 💬 Popup résultat
  void showResult() {
    isGameOver = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ResultDialog(score: score, won: score >= 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount = width > 600 ? 5 : 3;

    return Scaffold(
      appBar: AppBar(title: Text('Jeu des Fruits 🍎'), centerTitle: true),

      body: Container(
        // 🎨 Background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade200, Colors.orange.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 500),
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 10),

                // 🏆 Score
                ScoreBoard(score: score),

                SizedBox(height: 10),

                // ⏱️ Timer
                TimerWidget(timeLeft: timeLeft),

                SizedBox(height: 20),

                // 🎯 Fruit cible
                Text(
                  'Trouve : ${targetFruit.name}',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 20),

                // 🎬 Grille animée
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: GridView.builder(
                      itemCount: fruits.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return FruitCard(
                          fruit: fruits[index],
                          onTap: () => handleFruitTap(fruits[index]),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
