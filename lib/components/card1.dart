import 'package:flutter/material.dart';
import 'package:structureflutter/models/explore_recipe.dart';
import 'package:structureflutter/theme/fooderlich_theme.dart';

class Card1 extends StatelessWidget {
  final ExploreRecipe recipe;

  const Card1({Key? key, required this.recipe}) : super(key: key);

  final String category = 'Editor\'s Choice';
  final String title = 'The Art of Dough';
  final String description = 'Learn to make the perfect bread.';
  final String chef = 'Ray Wenderlich';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints.expand(
        width: 350,
        height: 450,
      ),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/mag1.png'),
          fit: BoxFit.cover,
        ),
        border: Border.all(color: Colors.black, width: 2.0),
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Stack(
        children: [
          Text(
            category,
            style: FooderlichTheme.darkTextTheme.bodyText1,
          ),
          Positioned(
            top: 20,
            child: Text(
              title,
              style: FooderlichTheme.darkTextTheme.headline5,
            ),
          ),
          Positioned(
            bottom: 30,
            right: 0,
            child: Text(
              description,
              style: FooderlichTheme.darkTextTheme.bodyText1,
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Text(
              chef,
              style: FooderlichTheme.darkTextTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
