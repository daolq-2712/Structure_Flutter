import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:structureflutter/data/models/ingredient.dart';

import '../../data/repository.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  // TODO 1
  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final checkBoxValues = <int, bool>{};
  final _ingredients = <Ingredient>[];

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context);
    return StreamBuilder(
        stream: repository.watchAllIngredients(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final ingredients = snapshot.data;
            if (ingredients != null) {
              _ingredients.addAll(ingredients);
            }
            if (_ingredients.isEmpty) {
              return Container();
            }
            return ListView.builder(
                itemCount: _ingredients.length,
                itemBuilder: (BuildContext context, int index) {
                  return CheckboxListTile(
                    value: checkBoxValues.containsKey(index) &&
                        checkBoxValues[index]!,
                    title: Text(_ingredients[index].name ?? ''),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        setState(() {
                          checkBoxValues[index] = newValue;
                        });
                      }
                    },
                  );
                });
          } else {
            return Container();
          }
        });
  }
}
