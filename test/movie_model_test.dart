import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie model tests', () {
    test('Movie constructor assigns properties correctly', () {
      const movie = Movie(
        id: '1',
        title: 'Avengers Endgame',
        synopsis:
            'After Thanos, an intergalactic warlord, disintegrates half of the universe, the Avengers must reunite and assemble again to reinvigorate their trounced allies and restore balance.',
        ageRating: '12A',
        screeningTiming: '3h 5m',
        ticketPrice: 12.50,
        posterImagePath: 'assets/images/Avengers Endgame.jpg',
      );

      expect(movie.id, '1');
      expect(movie.title, 'Avengers Endgame');
      expect(movie.synopsis,
          'After Thanos, an intergalactic warlord, disintegrates half of the universe, the Avengers must reunite and assemble again to reinvigorate their trounced allies and restore balance.');
      expect(movie.ageRating, '12A');
      expect(movie.screeningTiming, '3h 5m');
      expect(movie.ticketPrice, 12.50);
      expect(movie.posterImagePath, 'assets/images/Avengers Endgame.jpg');
    });

    test('formattedPrice displays whole pounds with two decimal places', () {
      const movie = Movie(
        id: '2',
        title: 'Iron Man',
        synopsis:
            'When Tony Stark, an industrialist, is captured, he constructs a high-tech armoured suit to escape. Once he manages to escape, he decides to use his suit to fight against evil forces to save the world.',
        ageRating: '12A',
        screeningTiming: '2h 6m',
        ticketPrice: 10.0,
        posterImagePath: 'assets/images/Iron Man.jpg',
      );

      expect(movie.formattedPrice, '£10.00');
    });

    test('formattedPrice displays pence with two decimal places', () {
      const movie = Movie(
        id: '1',
        title: 'Avengers Endgame',
        synopsis:
            'After Thanos, an intergalactic warlord, disintegrates half of the universe, the Avengers must reunite and assemble again to reinvigorate their trounced allies and restore balance.',
        ageRating: '12A',
        screeningTiming: '3h 5m',
        ticketPrice: 12.50,
        posterImagePath: 'assets/images/Avengers Endgame.jpg',
      );

      expect(movie.formattedPrice, '£12.50');
    });
  });
}
