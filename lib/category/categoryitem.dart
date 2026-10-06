import 'package:flutter/material.dart';
import 'package:mymeal_app/category/categoriesmodel.dart';

class Categoryitem extends StatelessWidget {
  const Categoryitem({
    super.key,
    required this.category,
    required this.selectCategoryMeal,
  });
  final void Function() selectCategoryMeal;

  final Categoriesmodel category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      splashColor: Colors.black54,
      onTap: selectCategoryMeal,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              category.color.withValues(alpha: 0.5),
              category.color.withValues(alpha: 1),
            ],
            begin: AlignmentGeometry.bottomRight,
            end: AlignmentGeometry.topLeft,
          ),

          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          category.title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
