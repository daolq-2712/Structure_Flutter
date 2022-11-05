import 'package:flutter/material.dart';
import 'package:structureflutter/components/recipes_grid_view.dart';

import '../models/models.dart';
import '../api/mock_fooderlich_service.dart';

class RecipesScreen extends StatelessWidget {
  final _exploreService = MockFooderlichService();

  RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _exploreService.getRecipes(),
      builder: (context, AsyncSnapshot<List<SimpleRecipe>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return RecipesGridView(recipes: snapshot.data ?? []);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
