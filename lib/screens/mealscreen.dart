import 'package:flutter/material.dart';

import 'package:mymeal_app/meals/mealmodel.dart';

class Mealscreen extends StatelessWidget {
  const Mealscreen({
    super.key,
    required this.meal,
    this.title,
    required this.onTapMeal,
    required this.isEmptyTextTitle,
    required this.isEmptyTextSubTitle,
    required this.addtofavorite,
  });
  final List<Mealmodel> meal;
  final String? title;
  final void Function(Mealmodel mymeal) onTapMeal;
  final String isEmptyTextTitle;
  final String isEmptyTextSubTitle;
  final void Function(Mealmodel mymeal) addtofavorite;

  // void onTappMeal(BuildContext context, Mealmodel meal) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => Mealdetailscreen(
  //         myMeal: meal,
  //         addToFavorite: (Mealmodel myMeal) {
  //           addtofavorite;
  //         },
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meal.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            onTapMeal(meal[index]);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),

            child: Stack(
              children: [
                FadeInImage.assetNetwork(
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: 300,
                  placeholder: 'lib/assets/loading.gif',
                  image: meal[index].imageurl,
                ),
                // FadeInImage(
                //   fadeInDuration: Duration(seconds: 2),
                //   height: 300,
                //   width: double.infinity,
                //   fit: BoxFit.cover,
                //   placeholder: MemoryImage(kTransparentImage),
                //   image: NetworkImage(meal[index].imageurl),
                // ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    color: Colors.black54,
                    child: Column(
                      spacing: 5,
                      children: [
                        Text(
                          meal[index].title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              spacing: 4,
                              children: [
                                Icon(
                                  Icons.more_time_outlined,
                                  color: Colors.white,
                                ),
                                Text(
                                  meal[index].duration.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 30),
                            Row(
                              spacing: 4,
                              children: [
                                Icon(
                                  Icons.payments_outlined,
                                  color: Colors.white,
                                ),
                                Text(
                                  meal[index].affordability.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 30),
                            Row(
                              spacing: 4,
                              children: [
                                Icon(Icons.work_outline, color: Colors.white),
                                Text(
                                  meal[index].complexity.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (meal.isEmpty) {
      content = Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                textAlign: TextAlign.center,
                isEmptyTextTitle,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(textAlign: TextAlign.center, isEmptyTextSubTitle),
            ],
          ),
        ),
      );
    }
    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: content,
    );
  }
}
