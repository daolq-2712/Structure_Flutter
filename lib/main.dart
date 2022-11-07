import 'package:flutter/material.dart';
import 'home.dart';
import 'theme/fooderlich_theme.dart';
import 'package:provider/provider.dart';
import 'models/models.dart';

void main() {
  // 1
  runApp(const Fooderlich());
}

class Fooderlich extends StatelessWidget {
  // 2
  const Fooderlich({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = FooderlichTheme.light();
    // 3
    return MaterialApp(
      theme: theme,
      title: 'Fooderlich',
      // 4
      home: MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => TabManager())],
        child: const Home(),
      ),
    );
  }
}
