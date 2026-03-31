class FruitModel {
  final String name;       // Nom du fruit
  final String imagePath;  // Chemin de l'image
  final bool isTarget;     // Si c'est le fruit à trouver

  FruitModel({
    required this.name,
    required this.imagePath,
    this.isTarget = false,
  });

  // Méthode pour créer une copie avec modification
  FruitModel copyWith({bool? isTarget}) {
    return FruitModel(
      name: name,
      imagePath: imagePath,
      isTarget: isTarget ?? this.isTarget,
    );
  }
}