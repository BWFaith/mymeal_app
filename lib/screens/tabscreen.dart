import 'package:flutter/material.dart';
import 'package:mymeal_app/meals/meallist.dart';

import 'package:mymeal_app/meals/mealmodel.dart';
import 'package:mymeal_app/screens/categoryscreen.dart';
import 'package:mymeal_app/screens/filterscreen.dart';
import 'package:mymeal_app/screens/mealdetailscreen.dart';
import 'package:mymeal_app/screens/mealscreen.dart';

const kInitialFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class Tabscreen extends StatefulWidget {
  const Tabscreen({super.key});

  @override
  State<Tabscreen> createState() => _TabscreenState();
}

class _TabscreenState extends State<Tabscreen> {
  Map<Filter, bool> selectedFilters = kInitialFilter;

  void onTappMeal(Mealmodel meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            Mealdetailscreen(myMeal: meal, addToFavorite: addToFavorite),
      ),
    );
  }

  int navigationIndex = 0;

  void selectedPage(int index) {
    setState(() {
      navigationIndex = index;
    });
  }

  List<Mealmodel> favoriteMeal = [];

  void addtofaboritemessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void addToFavorite(Mealmodel meal) {
    final isFavoriteMeal = favoriteMeal.contains(meal);
    if (isFavoriteMeal) {
      setState(() {
        favoriteMeal.remove(meal);
      });
      addtofaboritemessage('Meal removed from favorite...');
    } else {
      setState(() {
        favoriteMeal.add(meal);
      });
      addtofaboritemessage('Meal added to favorite...');
    }
  }

  @override
  Widget build(BuildContext context) {
    final availablemeals = meallist.where((meal) {
      if (selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    String pageTitle = 'Choose your category...';

    Widget activePage = Categoryscreen(
      onTapMeal: (selectedMeal) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Mealdetailscreen(
              myMeal: selectedMeal,
              addToFavorite: addToFavorite,
            ),
          ),
        );
      },
      addToFavorite: addToFavorite,
      filteredList: availablemeals,
    );

    if (navigationIndex == 1) {
      activePage = Mealscreen(
        meal: favoriteMeal,
        onTapMeal: onTappMeal,
        isEmptyTextTitle: 'Opps, there is currently no meals in favorite...',
        isEmptyTextSubTitle: 'Add some meals to favorite',
        addtofavorite: (Mealmodel meal) {
          addToFavorite;
        },
      );
      pageTitle = 'Favorites...';
    }

    return Scaffold(
      appBar: AppBar(title: Text(pageTitle)),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepOrange),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.dinner_dining_rounded,
                    color: Colors.white,
                    size: 64,
                  ),
                  Text(
                    'JustMeal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
              },
              leading: Icon(Icons.dining_outlined),
              title: Text(
                'Select your Meal',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            ListTile(
              onTap: () async {
                Navigator.of(context).pop();
                final result = await Navigator.of(context)
                    .push<Map<Filter, bool>>(
                      MaterialPageRoute(
                        builder: (context) {
                          return Filterscreen(updatefilter: selectedFilters);
                        },
                      ),
                    );
                setState(() {
                  selectedFilters = result ?? selectedFilters;
                });
              },
              leading: Icon(Icons.settings),
              title: Text(
                'Filter Settings',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationIndex,

        onTap: (index) => selectedPage(index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal_outlined),
            label: 'Meals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_outlined),
            label: 'Favorites',
          ),
        ],
      ),
      body: activePage,
    );
  }
}
