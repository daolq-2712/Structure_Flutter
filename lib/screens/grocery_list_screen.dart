import 'package:flutter/material.dart';
import 'package:structureflutter/components/grocery_tile.dart';
import 'package:structureflutter/models/grocery_manager.dart';
import 'package:structureflutter/screens/grocery_item_screen.dart';

class GroceryListScreen extends StatelessWidget {
  final GroceryManager manager;

  const GroceryListScreen({Key? key, required this.manager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groceryItems = manager.groceryItems;
    // replace with list grocery
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
          itemBuilder: (context, index) {
            final item = groceryItems[index];
            return InkWell(
              child: GroceryTile(
                item: item,
                onComplete: (change) {
                  if (change != null) {
                    manager.completeItem(index, change);
                  }
                },
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return GroceryItemScreen(
                      originalItem: item,
                      onCreate: (item) {
                        // TODO implement create item later
                      },
                      onUpdate: (item) {
                        manager.updateItem(item, index);
                        Navigator.pop(context);
                      });
                }));
              },
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
          itemCount: groceryItems.length),
    );
  }
}
