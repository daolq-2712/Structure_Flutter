import 'package:flutter/material.dart';
import 'package:structureflutter/home.dart';
import 'package:structureflutter/theme/fooderlich_theme.dart';

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
      home: const Home(),
    );
  }
}
