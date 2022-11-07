import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:structureflutter/models/grocery_manager.dart';
import 'empty_grocery_screen.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
// TODO 4: Add a scaffold widget
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // TODO 11: Present GroceryItemScreen
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
