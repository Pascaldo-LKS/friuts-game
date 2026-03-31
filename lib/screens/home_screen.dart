import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/sound_service.dart';
import 'game_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  int highScore = 0;

  @override
  void initState() {
    super.initState();

    // 🎬 Animation
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _scaleAnimation = Tween(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();

    // 🏆 Charger score
    loadScore();

    // 🎵 Musique
    SoundService.playBackgroundMusic();
  }

  Future<void> loadScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      highScore = prefs.getInt('high_score') ?? 0;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 🌟 Bulles animées
  Widget buildBubble(double size, double top, double left) {
    return Positioned(
      top: top,
      left: left,
      child: TweenAnimationBuilder(
        tween: Tween(begin: 0.8, end: 1.2),
        duration: Duration(seconds: 3),
        curve: Curves.easeInOut,
        builder: (context, double value, child) {
          return Transform.scale(
            scale: value,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [

          // 🎨 Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade400,
                  Colors.orange.shade300,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // 🌟 Bulles
          buildBubble(100, 100, 50),
          buildBubble(150, 300, 200),
          buildBubble(80, 500, 100),
          buildBubble(120, 200, width - 150),

          // 🧩 Contenu
          Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 500),
              padding: EdgeInsets.all(20),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      // 🍎 Logo
                      Hero(
                        tag: 'logo',
                        child: Image.asset(
                          'assets/images/apple.png',
                          height: 100,
                        ),
                      ),

                      SizedBox(height: 20),

                      // 📝 Titre
                      Text(
                        'Jeu des Fruits',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),

                      SizedBox(height: 10),

                      // 🧠 Description
                      Text(
                        'Teste ta rapidité et trouve le bon fruit 🍉',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),

                      SizedBox(height: 30),

                      // 🏆 High Score
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '🏆 Meilleur score : $highScore',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: 40),

                      // 🎮 Bouton jouer
                      GestureDetector(
                        onTap: () {
                          SoundService.stopBackgroundMusic();

                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  Duration(milliseconds: 600),
                              pageBuilder: (_, __, ___) => GameScreen(),
                              transitionsBuilder:
                                  (_, animation, __, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 60, vertical: 18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              )
                            ],
                          ),
                          child: Text(
                            'JOUER',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 25),

                      // ⚙️ Paramètres
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/settings');
                        },
                        child: Text(
                          '⚙️ Paramètres',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      // ℹ️ About
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/about');
                        },
                        child: Text(
                          'ℹ️ À propos',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}