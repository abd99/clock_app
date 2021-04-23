import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:clock_app/app/app.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ClockApp());

    // Verify that our counter starts at 0.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
