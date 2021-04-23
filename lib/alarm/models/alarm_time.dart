import 'package:flutter/foundation.dart';

class AlarmTime {
  final int year;
  final int month;
  final int day;
  final int hour;
  final int minute;

  AlarmTime({
    @required this.year,
    @required this.month,
    @required this.day,
    @required this.hour,
    @required this.minute,
  });

  Map<String, dynamic> toMap() {
    return {
      'year': year,
      'month': month,
      'day': day,
      'hour': hour,
      'minute': minute,
    };
  }
}
