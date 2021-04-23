import 'package:clock_app/analog_clock/analog_clock.dart';
import 'package:clock_app/clock/clock.dart';
import 'package:clock_app/digital_clock/digital_clock.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClockView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ClockPreference>(
      builder: (context, value, child) {
        var textTheme = Theme.of(context).textTheme;
        var digitalClock = DigitalClock();
        return Column(
          children: [
            value.showAnalog
                ? AnalogClock()
                : Container(
                    width: 300.0,
                    height: 300.0,
                    child: Center(
                      child: digitalClock,
                    ),
                  ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Digital',
                  style: textTheme.bodyText1.copyWith(
                    color: !value.showAnalog
                        ? Colors.blue.shade900
                        : Colors.grey.shade400,
                  ),
                ),
                Switch(
                  value: value.showAnalog,
                  onChanged: (newValue) {
                    value.toggleClockType();
                  },
                ),
                Text(
                  'Analog',
                  style: textTheme.bodyText1.copyWith(
                    color: value.showAnalog
                        ? Colors.blue.shade900
                        : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
