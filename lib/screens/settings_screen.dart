import 'package:flutter/material.dart';
import '../services/settings_service.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String difficulty = SettingsService.difficulty;
  bool soundEnabled = SettingsService.soundEnabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🎯 Difficulté
            Text(
              'Difficulté',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            DropdownButton<String>(
              value: difficulty,
              items: ['Facile', 'Moyen', 'Difficile']
                  .map((level) => DropdownMenuItem(
                        value: level,
                        child: Text(level),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  difficulty = value!;
                  SettingsService.difficulty = value;
                });
              },
            ),

            SizedBox(height: 30),

            // 🔊 Son
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Son',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Switch(
                  value: soundEnabled,
                  onChanged: (value) {
                    setState(() {
                      soundEnabled = value;
                      SettingsService.soundEnabled = value;
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 40),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Paramètres sauvegardés ✅')),
                  );
                },
                child: Text('Sauvegarder'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}