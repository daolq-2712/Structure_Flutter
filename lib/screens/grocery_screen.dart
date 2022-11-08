import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:structureflutter/models/grocery_manager.dart';
import 'package:structureflutter/screens/grocery_item_screen.dart';
import 'empty_grocery_screen.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final manager = Provider.of<GroceryManager>(context, listen: false);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GroceryItemScreen(
                  onCreate: (item) {
                    manager.addItem(item);
                    Navigator.pop(context);
                  },
                  onUpdate: (item) {

                  },
                ),
              ));
        },
      ),
      body: _buildGroceryScreen(),
    );
  }

  Widget _buildGroceryScreen() {
    return Consumer<GroceryManager>(
      builder: (context, manager, child) {
        if (manager.groceryItems.isNotEmpty) {
          // TODO 25: Add grocery screen
          return Container();
        } else {
          return const EmptyGroceryScreen();
        }
      },
    );
  }
}
