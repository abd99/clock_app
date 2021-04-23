import 'package:clock_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import '../home/home.dart';

class ClockApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clock App',
      theme: AppTheme.appTheme,
      home: HomePage(title: 'Flutter Clock App'),
    );
  }
}
