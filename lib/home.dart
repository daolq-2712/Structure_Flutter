import 'package:flutter/material.dart';
import 'package:structureflutter/screens/recipes_screen.dart';
import 'screens/grocery_screen.dart';
import 'screens/explore_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _seletedIndex = 0;
  static List<Widget> pages = [
    const ExploreScreen(),
    RecipesScreen(),
    GroceryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _seletedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fooderlich',
          // 2
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: pages[_seletedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _seletedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'To Buy',
          ),
        ],
      ),
    );
  }
}
