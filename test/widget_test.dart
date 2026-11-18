import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';

void main() {
  testWidgets('Basic app loading test', (WidgetTester tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());

    await tester.pumpAndSettle();

    expect(find.text('Welcome to Southsea Cinema'), findsOneWidget);
    expect(find.text('Avengers Endgame'), findsOneWidget);
    expect(find.text('Iron Man'), findsOneWidget);
  });
}
