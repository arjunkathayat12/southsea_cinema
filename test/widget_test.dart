import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/views/movie_listing.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';

void main() {
  testWidgets('Basic app loading test', (WidgetTester tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());
    await tester.pumpAndSettle();

    expect(find.text('Welcome to Southsea Cinema'), findsOneWidget);
    expect(find.text('Avengers Endgame'), findsOneWidget);
    expect(find.text('Iron Man'), findsOneWidget);
  });

  testWidgets('Complete movie booking flow', (WidgetTester tester) async {
    // Start with an empty basket.
    BasketRepository.instance.clear();
    addTearDown(() => BasketRepository.instance.clear());

    // Get a movie from the movie repository.
    final Movie selectedMovie = MovieRepository().getMovies().first;

    // Display the selected movie card.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            children: [
              MovieCard(movie: selectedMovie),
            ],
          ),
        ),
      ),
    );

    // Check that the movie card is displayed.
    expect(find.byType(MovieCard), findsOneWidget);

    // Find BOOK NOW button.
    final bookNowButton = find.text('BOOK NOW');

    expect(bookNowButton, findsOneWidget);

    // Tap BOOK NOW.
    await tester.ensureVisible(bookNowButton);
    await tester.tap(bookNowButton);
    await tester.pumpAndSettle();

    // Check that MovieListing opens.
    expect(find.byType(MovieListing), findsOneWidget);

    // Check the selected movie details.
    expect(find.text(selectedMovie.title), findsOneWidget);

    expect(find.text(selectedMovie.synopsis), findsOneWidget);

    expect(
      find.text('Age rating: ${selectedMovie.ageRating}'),
      findsOneWidget,
    );

    expect(
      find.text('Screening: ${selectedMovie.screeningTiming}'),
      findsOneWidget,
    );

    // Find Add To Order button.
    final addButton = find.text('Add To Order');

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

    // Open the ticket dropdown.
    await tester.tap(find.byType(DropdownMenu<int>));
    await tester.pumpAndSettle();

    // Select one ticket.
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

    // Check updated total using the selected movie's actual price.
    expect(
      find.text(
        'Total: £${selectedMovie.ticketPrice.toStringAsFixed(2)}',
      ),
      findsOneWidget,
    );

    // Check that the ticket was saved in BasketRepository.
    expect(
      BasketRepository.instance.getTotalTickets(),
      1,
    );

    expect(
      BasketRepository.instance.getTotal(),
      selectedMovie.ticketPrice,
    );

    // Check the correct movie was saved.
    expect(
      BasketRepository.instance.getTickets().first.movieTitle,
      selectedMovie.title,
    );
  });
}
