import 'package:flutter/material.dart';

import 'colors.dart';

final ThemeData defaultTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: backgroundColor,
  appBarTheme: const AppBarTheme(
    color: backgroundColor,
    iconTheme: IconThemeData(color: accentLightColor),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: accentLightColor,
    disabledColor: primaryColorDark,
  ),
);
