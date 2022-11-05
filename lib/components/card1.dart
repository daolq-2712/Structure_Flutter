import 'package:flutter/material.dart';
import 'package:structureflutter/models/explore_recipe.dart';
import 'package:structureflutter/theme/fooderlich_theme.dart';

class Card1 extends StatelessWidget {
  final ExploreRecipe recipe;

  const Card1({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints.expand(
        width: 350,
        height: 450,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(recipe.backgroundImage),
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
            recipe.subtitle,
            style: FooderlichTheme.darkTextTheme.bodyText1,
          ),
          Positioned(
            top: 20,
            child: Text(
              recipe.title,
              style: FooderlichTheme.darkTextTheme.headline5,
            ),
          ),
          Positioned(
            bottom: 30,
            right: 0,
            child: Text(
              recipe.message,
              style: FooderlichTheme.darkTextTheme.bodyText1,
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Text(
              recipe.authorName,
              style: FooderlichTheme.darkTextTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
