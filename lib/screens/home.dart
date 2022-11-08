import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../fooderlich_pages.dart';
import '../models/models.dart';
import 'recipes_screen.dart';
import 'grocery_screen.dart';
import 'explore_screen.dart';

class Home extends StatefulWidget {
  static MaterialPage page(int currentTab) {
    return MaterialPage(
      name: FooderlichPages.home,
      key: ValueKey(FooderlichPages.home),
      child: Home(
        currentTab: currentTab,
      ),
    );
  }

  final int currentTab;

  const Home({Key? key, required this.currentTab}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<Widget> pages = [
    const ExploreScreen(),
    RecipesScreen(),
    const GroceryScreen(),
  ];

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
      body: IndexedStack(
        index: widget.currentTab,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentTab,
        onTap: (index) {
          Provider.of<AppStateManager>(context, listen: false).goToTab(index);
        },
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
    // return Consumer<AppStateManager>(
    //     builder: (context, appStateManager, child) {
    //       return Scaffold(
    //         appBar: AppBar(
    //           title: Text(
    //             'Fooderlich',
    //             // 2
    //             style: Theme.of(context).textTheme.headline6,
    //           ),
    //         ),
    //         body: IndexedStack(
    //           index: widget.currentTab,
    //           children: pages,
    //         ),
    //         bottomNavigationBar: BottomNavigationBar(
    //           currentIndex: widget.currentTab,
    //           onTap: (index) {
    //             Provider.of<AppStateManager>(context, listen: false).goToTab(index);
    //           },
    //           selectedItemColor:
    //           Theme.of(context).textSelectionTheme.selectionColor,
    //           items: const [
    //             BottomNavigationBarItem(
    //               icon: Icon(Icons.explore),
    //               label: 'Explore',
    //             ),
    //             BottomNavigationBarItem(
    //               icon: Icon(Icons.book),
    //               label: 'Recipes',
    //             ),
    //             BottomNavigationBarItem(
    //               icon: Icon(Icons.list),
    //               label: 'To Buy',
    //             ),
    //           ],
    //         ),
    //       );
    //     });
  }
}
