import 'package:flutter/material.dart';
import '../models/fruit_model.dart';

class FruitCard extends StatelessWidget {
  final FruitModel fruit;
  final VoidCallback onTap;

  FruitCard({required this.fruit, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Action quand on clique sur le fruit
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Image.asset(
            fruit.imagePath, // Image du fruit
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}