import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/main.dart';

void main() {
  testWidgets('Counter increments correctly', (WidgetTester tester) async {
    // Load the app
    await tester.pumpWidget(const MyApp());

    // Verify initial counter value is 0
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump(); // Rebuild widget

    // Verify counter value updates to 1
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Counter decrements correctly', (WidgetTester tester) async {
    // Load the app
    await tester.pumpWidget(const MyApp());

    // Tap the '+' button to increase the counter
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify counter is now 1
    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsNothing);

    // Tap the '-' button to decrease the counter
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();

    // Verify counter is back to 0
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
  });

  testWidgets('Floating action buttons are present', (WidgetTester tester) async {
    // Load the app
    await tester.pumpWidget(const MyApp());

    // Verify '+' button exists
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Verify '-' button exists
    expect(find.byIcon(Icons.remove), findsOneWidget);
  });
}

