import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/views/movie_listing.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';

void main() {
  testWidgets(
    'JSON movie loading and complete booking flow',
    (WidgetTester tester) async {
      // Start with an empty basket.
      BasketRepository.instance.clear();
      addTearDown(() => BasketRepository.instance.clear());

      // Open the actual application.
      await tester.pumpWidget(const SouthseaCinemaApp());

      // Wait for movies to load from the JSON asset.
      await tester.pumpAndSettle();

      // Check the home page.
      expect(
        find.text('Welcome to Southsea Cinema'),
        findsOneWidget,
      );

      expect(find.text('Avengers Endgame'), findsOneWidget);
      expect(find.text('Iron Man'), findsOneWidget);
      expect(find.byType(MovieCard), findsNWidgets(2));

      // Find the first movie card.
      final movieCard = find.byType(MovieCard).first;

      // Get the selected movie details.
      final selectedMovie = tester.widget<MovieCard>(movieCard).movie;

      // Find BOOK NOW.
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

      // Check selected movie details.
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

      // Find Add To Order.
      final addButton = find.descendant(
        of: movieListing,
        matching: find.text('Add To Order'),
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

      // Open ticket dropdown.
      await tester.tap(find.byType(DropdownMenu<int>));
      await tester.pumpAndSettle();

      // Select one ticket.
      await tester.tap(find.text('1').last);
      await tester.pumpAndSettle();

      // Add the selected ticket.
      await tester.ensureVisible(addButton);
      await tester.tap(addButton);
      await tester.pump();

      // Check successful feedback.
      expect(
        find.text('1 tickets added to your order.'),
        findsOneWidget,
      );

      // Check updated total.
      expect(
        find.text(
          'Total: £${selectedMovie.ticketPrice.toStringAsFixed(2)}',
        ),
        findsOneWidget,
      );

      // Check basket repository contents.
      expect(
        BasketRepository.instance.getTotalTickets(),
        1,
      );

      expect(
        BasketRepository.instance.getTotal(),
        selectedMovie.ticketPrice,
      );

      expect(
        BasketRepository.instance.getTickets().first.movieTitle,
        selectedMovie.title,
      );
    },
  );
}
