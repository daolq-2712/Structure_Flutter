import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_router.dart';
import 'models/models.dart';
import 'theme/fooderlich_theme.dart';
// TODO: Import app_router

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Fooderlich());
}

class Fooderlich extends StatefulWidget {
  const Fooderlich({super.key});

  @override
  FooderlichState createState() => FooderlichState();
}

class FooderlichState extends State<Fooderlich> {
  late final _appStateManager = AppStateManager();
  late final _groceryManager = GroceryManager();
  late final _profileManager = ProfileManager();

  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      groceryManager: _groceryManager,
      profileManager: _profileManager,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _groceryManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _profileManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _appStateManager,
        ),
      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, child) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = FooderlichTheme.dark();
          } else {
            theme = FooderlichTheme.light();
          }

          return MaterialApp(
            theme: theme,
            title: 'Fooderlich',
            home: Router(
              routerDelegate: _appRouter,
              backButtonDispatcher: RootBackButtonDispatcher(),
            ),
          );
        },
      ),
    );
  }
}
