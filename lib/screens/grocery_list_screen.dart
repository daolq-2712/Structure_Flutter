import 'package:flutter/material.dart';
import 'package:structureflutter/components/grocery_tile.dart';
import 'package:structureflutter/models/grocery_manager.dart';

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
            return Dismissible(
              key: Key(item.id),
              direction: DismissDirection.endToStart,
              background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  child: const Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                    size: 50,
                  )),
              onDismissed: (direction) {
                manager.deleteItem(index);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${item.name} dismissed!'),
                ));
              },
              child: InkWell(
                child: GroceryTile(
                  item: item,
                  onComplete: (change) {
                    if (change != null) {
                      manager.completeItem(index, change);
                    }
                  },
                ),
                onTap: () {
                  manager.groceryItemTapped(index);
                },
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
          itemCount: groceryItems.length),
    );
  }
}
