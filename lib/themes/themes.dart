import 'package:flutter/material.dart';
import 'package:notes/themes/pallette.dart';

ThemeData darkMode = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Pallette.black,
    textTheme: TextTheme(labelSmall: TextStyle(color: Pallette.white)),
    appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Pallette.black,
        foregroundColor: Pallette.white));

ThemeData lightMode = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Pallette.white,
    textTheme: TextTheme(labelSmall: TextStyle(color: Pallette.white)),
    appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Pallette.white,
        foregroundColor: Pallette.blue));

final textStyle = TextStyle(color: Pallette.white);
