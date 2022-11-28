import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'presentation/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie DB',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('vi', 'VI'),
      ],
      home: const HomePage(),
    );
  }
}
