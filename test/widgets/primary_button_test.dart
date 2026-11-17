import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

void main() {
  testWidgets('PrimaryButton displays label and responds to tap',
      (WidgetTester tester) async {
    bool buttonPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            label: 'Book Tickets',
            onPressed: () {
              buttonPressed = true;
            },
          ),
        ),
      ),
    );

    // Check that the button label appears
    expect(find.text('Book Tickets'), findsOneWidget);

    // Tap the button
    await tester.tap(find.text('Book Tickets'));
    await tester.pump();

    // Check that the callback was executed
    expect(buttonPressed, true);
  });
}
