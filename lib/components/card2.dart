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
        image: const DecorationImage(
          image: AssetImage('assets/mag5.png'),
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
          const AuthorCard(
            authorName: 'Mike Katz',
            title: 'Smoothie Connoisseur',
            imageProvider: AssetImage('assets/author_katz.jpeg'),
          ),
          Expanded(
            child: Stack(children: [
              Positioned(
                left: 10,
                bottom: 70,
                child: RotatedBox(
                  quarterTurns: 45,
                  child: Text(
                    'Smoothies',
                    style: FooderlichTheme.lightTextTheme.headline1,
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                right: 10,
                child: Text(
                  'Recipe',
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
