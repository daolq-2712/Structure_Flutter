import 'package:flutter/material.dart';

import '../models/models.dart';
import 'components.dart';

class TodayRecipeListView extends StatelessWidget {
  final List<ExploreRecipe> recipes;

  const TodayRecipeListView({
    Key? key,
    required this.recipes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text('Recipes of the Day 🍳',
                style: Theme.of(context).textTheme.headline1),
          ),
          const SizedBox(height: 16),
          Container(
            height: 400,
            color: Colors.grey,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return _buildCard(recipe);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 16);
                },
                itemCount: recipes.length),
          )
        ],
      ),
    );
  }

  Widget _buildCard(ExploreRecipe recipe) {
    if (recipe.cardType == RecipeCardType.card1) {
      return Card1(recipe: recipe);
    } else if (recipe.cardType == RecipeCardType.card2) {
      return Card2(recipe: recipe);
    } else if (recipe.cardType == RecipeCardType.card3) {
      return Card3(recipe: recipe);
    } else {
      throw Exception('This card doesn\'t exist yet');
    }
  }
}
