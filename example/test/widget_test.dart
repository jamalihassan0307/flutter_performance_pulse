import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_performance_pulse_example/main.dart';

void main() {
  testWidgets('Example app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our buttons are present
    expect(find.text('Perform Heavy Task'), findsOneWidget);
    expect(find.text('Make Network Request'), findsOneWidget);

    // Tap the heavy task button and verify loading state
    await tester.tap(find.text('Perform Heavy Task'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the task to complete
    await tester.pumpAndSettle();
    expect(find.text('Perform Heavy Task'), findsOneWidget);
  });
}
