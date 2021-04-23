import 'package:flutter/material.dart';

class AppTheme {
  static final appTheme = ThemeData(
    primarySwatch: Colors.blue,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      elevation: 0.0,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.black,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
