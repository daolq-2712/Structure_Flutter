import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../data/models/recipe.dart';
import '../../data/repository.dart';

class MyRecipesList extends StatefulWidget {
  const MyRecipesList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyRecipesListState createState() => _MyRecipesListState();
}

class _MyRecipesListState extends State<MyRecipesList> {
  final List<Recipe> _recipes = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context, listen: false);
    return StreamBuilder<List<Recipe>>(
      stream: repository.watchAllRecipes(),
      builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final recipes = snapshot.data ?? [];
          _recipes.addAll(recipes);
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildRecipeList(context, repository),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildRecipeList(BuildContext context, Repository repository) {
    return ListView.builder(
        itemCount: _recipes.length,
        itemBuilder: (BuildContext context, int index) {
          final recipe = _recipes[index];
          return SizedBox(
            height: 100,
            child: Slidable(
              actionPane: const SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              actions: <Widget>[
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.transparent,
                  foregroundColor: Colors.black,
                  iconWidget: const Icon(Icons.delete, color: Colors.red),
                  onTap: () => deleteRecipe(repository, recipe),
                )
              ],
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.transparent,
                  foregroundColor: Colors.black,
                  iconWidget: const Icon(Icons.delete, color: Colors.red),
                  onTap: () => deleteRecipe(repository, recipe),
                )
              ],
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CachedNetworkImage(
                          imageUrl: recipe.image ?? '',
                          height: 120,
                          width: 60,
                          fit: BoxFit.cover),
                      title: Text(recipe.label ?? ''),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
    // TODO 9
  }

  void deleteRecipe(Repository repository, Recipe recipe) {
    if (recipe.id != null) {
      repository.deleteRecipe(recipe);
      setState(() {});
    } else {
      if (kDebugMode) {
        print('Recipe id is null');
      }
    }
  }
}
