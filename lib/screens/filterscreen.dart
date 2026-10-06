import 'package:flutter/material.dart';

enum Filter { glutenFree, lactoseFree, vegan, vegetarian }

class Filterscreen extends StatefulWidget {
  const Filterscreen({super.key, required this.updatefilter});
  final Map<Filter, bool> updatefilter;
  @override
  State<Filterscreen> createState() => _FilterscreenState();
}

class _FilterscreenState extends State<Filterscreen> {
  var glutenFree = false;
  var isLactoseFree = false;
  var isVegan = false;
  var isVegetarian = false;

  @override
  void initState() {
    glutenFree = widget.updatefilter[Filter.glutenFree]!;
    isLactoseFree = widget.updatefilter[Filter.lactoseFree]!;
    isVegan = widget.updatefilter[Filter.vegan]!;
    isVegetarian = widget.updatefilter[Filter.vegetarian]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Filter Meals')),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: glutenFree,
            Filter.lactoseFree: isLactoseFree,
            Filter.vegan: isVegan,
            Filter.vegetarian: isVegetarian,
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: glutenFree,
              onChanged: (value) {
                setState(() {
                  glutenFree = value;
                });
              },
              title: Text(
                'isGlutenFree',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Meals that does not contain Gluten'),
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              activeThumbColor: Colors.deepOrange,
            ),
            Divider(
              height: 5,
              endIndent: 10,
              indent: 10,
              color: Colors.grey.shade200,
            ),
            SwitchListTile(
              value: isLactoseFree,
              onChanged: (value) {
                setState(() {
                  isLactoseFree = value;
                });
              },
              title: Text(
                'isLactoseFree',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Meals that does not contain Lactose'),
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              activeThumbColor: Colors.deepOrange,
            ),
            Divider(
              height: 5,
              endIndent: 10,
              indent: 10,
              color: Colors.grey.shade200,
            ),
            SwitchListTile(
              value: isVegan,
              onChanged: (value) {
                setState(() {
                  isVegan = value;
                });
              },
              title: Text(
                'isVeganFree',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Meals that does not contain vegan'),
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              activeThumbColor: Colors.deepOrange,
            ),
            Divider(
              height: 5,
              endIndent: 10,
              indent: 10,
              color: Colors.grey.shade200,
            ),
            SwitchListTile(
              value: isVegetarian,
              onChanged: (value) {
                setState(() {
                  isVegetarian = value;
                });
              },
              title: Text(
                'isVegetarianFree',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Meals that does not contain Vegetarian'),
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              activeThumbColor: Colors.deepOrange,
            ),
            Divider(
              height: 5,
              endIndent: 10,
              indent: 10,
              color: Colors.grey.shade200,
            ),
          ],
        ),
      ),
    );
  }
}
