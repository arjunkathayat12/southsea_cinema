import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/views/movie_listing.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';

void main() {
  testWidgets('Basic app loading test', (WidgetTester tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());
    await tester.pumpAndSettle();

    expect(find.text('Welcome to Southsea Cinema'), findsOneWidget);
  });

  testWidgets('Complete movie booking flow', (WidgetTester tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());
    await tester.pumpAndSettle();

    // Find the first movie card.
    final movieCard = find.byType(MovieCard).first;

    // Get the selected movie details.
    final selectedMovie = tester.widget<MovieCard>(movieCard).movie;

    // Find BOOK NOW inside the selected movie card.
    final bookNowButton = find.descendant(
      of: movieCard,
      matching: find.text('BOOK NOW'),
    );

    expect(bookNowButton, findsOneWidget);

    // Tap BOOK NOW.
    await tester.ensureVisible(bookNowButton);
    await tester.tap(bookNowButton);
    await tester.pumpAndSettle();

    // Check that MovieListing opens.
    final movieListing = find.byType(MovieListing);
    expect(movieListing, findsOneWidget);

    // Check the selected movie details.
    expect(
      find.descendant(
        of: movieListing,
        matching: find.text(selectedMovie.title),
      ),
      findsOneWidget,
    );

    expect(
      find.descendant(
        of: movieListing,
        matching: find.text(selectedMovie.synopsis),
      ),
      findsOneWidget,
    );

    expect(
      find.text('Age rating: ${selectedMovie.ageRating}'),
      findsOneWidget,
    );

    expect(
      find.text('Screening: ${selectedMovie.screeningTiming}'),
      findsOneWidget,
    );

    // Find Add To Order button.
    final addButton = find.descendant(
      of: movieListing,
      matching: find.widgetWithText(
        ElevatedButton,
        'Add To Order',
      ),
    );

    expect(addButton, findsOneWidget);

    // Tap without selecting tickets.
    await tester.ensureVisible(addButton);
    await tester.tap(addButton);
    await tester.pump();

    // Check warning feedback.
    expect(
      find.text('Please select the number of tickets.'),
      findsOneWidget,
    );

    // Select one ticket.
    await tester.tap(find.byType(DropdownMenu<int>));
    await tester.pumpAndSettle();

    await tester.tap(find.text('1').last);
    await tester.pumpAndSettle();

    // Tap Add To Order again.
    await tester.ensureVisible(addButton);
    await tester.tap(addButton);
    await tester.pump();

    // Check successful feedback.
    expect(
      find.text('1 tickets added to your order.'),
      findsOneWidget,
    );

    // Check updated total.
    expect(find.text('Total: £7.50'), findsOneWidget);
  });
}
