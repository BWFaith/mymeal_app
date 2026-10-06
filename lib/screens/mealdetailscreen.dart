import 'package:flutter/material.dart';

import 'package:mymeal_app/meals/mealmodel.dart';

class Mealdetailscreen extends StatefulWidget {
  const Mealdetailscreen({
    super.key,
    required this.myMeal,
    required this.addToFavorite,
  });
  final Mealmodel myMeal;
  final void Function(Mealmodel myMeal) addToFavorite;

  @override
  State<Mealdetailscreen> createState() => _MealdetailscreenState();
}

class _MealdetailscreenState extends State<Mealdetailscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.myMeal.title),
        actions: [
          IconButton(
            icon: Icon(
              widget.myMeal.isFavorite
                  ? Icons.star
                  : Icons.star_border_outlined,
              color: widget.myMeal.isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              setState(() {
                widget.myMeal.isFavorite = !widget.myMeal.isFavorite;
              });
              widget.addToFavorite(widget.myMeal);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(widget.myMeal.imageurl),
            SizedBox(height: 15),
            Column(
              children: [
                Text(
                  'Ingredients',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 5),
                for (var ingredients in widget.myMeal.ingredients)
                  Text(ingredients),
                SizedBox(height: 20),
                Text(
                  'Ingredients',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 5),
                for (var steps in widget.myMeal.steps) Text(steps),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
