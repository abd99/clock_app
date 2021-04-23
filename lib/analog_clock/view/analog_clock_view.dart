import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AnalogClock extends StatefulWidget {
  const AnalogClock({
    Key key,
  }) : super(key: key);

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  static final initialTime = DateTime.now();

  static double hoursAngle = (pi / 30) * initialTime.second;
  static double minutesAngle = (pi / 30) * initialTime.minute;
  static double secondsAngle =
      (pi / 6 * initialTime.hour) + (pi / 45 * minutesAngle);
  Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      final now = DateTime.now();
      setState(() {
        secondsAngle = (pi / 30) * now.second;
        minutesAngle = (pi / 30) * now.minute;
        hoursAngle = (pi / 6 * now.hour) + (pi / 45 * minutesAngle);
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
        side: BorderSide(
          color: Colors.black87,
          width: 8.0,
        ),
      ),
      margin: EdgeInsets.zero,
      elevation: 2.0,
      child: Container(
        width: 300,
        height: 300,
        child: Stack(
          children: [
            // Hour hand
            Transform.rotate(
              angle: hoursAngle,
              child: Container(
                child: Container(
                  height: 70.0,
                  width: 7.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                alignment: Alignment(0, -0.2),
              ),
            ),
            // Minute hand
            Transform.rotate(
              angle: minutesAngle,
              child: Container(
                child: Container(
                  height: 95.0,
                  width: 9.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                alignment: Alignment(0, -0.2),
              ),
            ),
            // Second hand
            Transform.rotate(
              angle: secondsAngle,
              child: Container(
                child: Container(
                  height: 140.0,
                  width: 2.0,
                  decoration: BoxDecoration(
                    color: Colors.red.shade800,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                alignment: Alignment(0, -0.35),
              ),
            ),
            // Dot
            Container(
              child: Container(
                height: 16.0,
                width: 16.0,
                decoration: BoxDecoration(
                  color: Colors.red.shade800,
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              alignment: Alignment(0, 0),
            ),
          ],
        ),
      ),
    );
  }
}
