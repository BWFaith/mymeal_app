import 'package:flutter/material.dart';
import 'package:mymeal_app/category/categoriesmodel.dart';

import 'package:mymeal_app/category/categoryitem.dart';
import 'package:mymeal_app/category/categorylist.dart';

import 'package:mymeal_app/meals/mealmodel.dart';
import 'package:mymeal_app/screens/mealdetailscreen.dart';

import 'package:mymeal_app/screens/mealscreen.dart';

class Categoryscreen extends StatefulWidget {
  const Categoryscreen({
    super.key,
    required this.onTapMeal,
    required this.addToFavorite,
    required this.filteredList,
  });
  final void Function(Mealmodel myMeal) addToFavorite;
  final List<Mealmodel> filteredList;
  final void Function(Mealmodel selectedMeal) onTapMeal;

  @override
  State<Categoryscreen> createState() => _CategoryscreenState();
}

class _CategoryscreenState extends State<Categoryscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onTappMeal(BuildContext context, Mealmodel meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            Mealdetailscreen(myMeal: meal, addToFavorite: widget.addToFavorite),
      ),
    );
  }

  void selectedMeal(BuildContext context, Categoriesmodel category) {
    final filteredCategory = widget.filteredList
        .where((meal) => meal.category.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Mealscreen(
            meal: filteredCategory,
            title: category.title,
            onTapMeal: (meal) {
              onTappMeal(context, meal);
            },
            isEmptyTextTitle:
                'Opps, there is currently no meal in this categoty yet...',
            isEmptyTextSubTitle: 'check back later.',
            addtofavorite: widget.addToFavorite,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            for (var category in categorylist)
              Categoryitem(
                category: category,
                selectCategoryMeal: () {
                  selectedMeal(context, category);
                },
              ),
          ],
        ),
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
    );
  }
}
