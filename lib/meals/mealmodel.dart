enum Affordability { affordable, pricey, luxurious }

enum Complexity { simple, challenging, hard }

class Mealmodel {
  Mealmodel({
    required this.id,
    required this.category,
    required this.title,
    required this.imageurl,
    required this.affordability,
    required this.duration,
    required this.ingredients,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
    required this.steps,
    required this.complexity,
    required this.isFavorite,
  });
  final String id;
  final Complexity complexity;
  final List<String> category;
  final String title;
  final String imageurl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Affordability affordability;
  bool isGlutenFree;
  bool isLactoseFree;
  bool isVegan;
  bool isVegetarian;
  bool isFavorite;
}
