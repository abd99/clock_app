import 'package:flutter/material.dart';

class ClockPreference extends ChangeNotifier {
  bool _showAnaglog = false;

  bool get showAnalog => _showAnaglog;

  void toggleClockType() {
    _showAnaglog = !_showAnaglog;
    notifyListeners();
  }
}
