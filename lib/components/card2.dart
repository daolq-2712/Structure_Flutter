import 'package:flutter/material.dart';
import 'package:structureflutter/components/author_card.dart';
import 'package:structureflutter/models/explore_recipe.dart';
import 'package:structureflutter/theme/fooderlich_theme.dart';

class Card2 extends StatelessWidget {
  final ExploreRecipe recipe;

  const Card2({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(width: 350, height: 450),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(recipe.backgroundImage),
          fit: BoxFit.cover,
        ),
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          AuthorCard(
            authorName: recipe.authorName,
            title: recipe.title,
            imageProvider: AssetImage(recipe.backgroundImage),
          ),
          Expanded(
            child: Stack(children: [
              Positioned(
                left: 10,
                bottom: 70,
                child: RotatedBox(
                  quarterTurns: 45,
                  child: Text(
                    recipe.title,
                    style: FooderlichTheme.lightTextTheme.headline1,
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                right: 10,
                child: Text(
                  recipe.subtitle,
                  style: FooderlichTheme.lightTextTheme.headline1,
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
