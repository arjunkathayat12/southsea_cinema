import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  group('MovieRepository unit tests', () {
    test('getMovies returns two movies', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      expect(movies.length, 2);
    });

    test('getMovies contains valid Avengers Endgame and Iron Man movies', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      final Movie avengers = movies[0];
      expect(avengers.id, '1');
      expect(avengers.title, 'Avengers Endgame');
      expect(avengers.posterImagePath, isNotEmpty);

      final Movie ironMan = movies[1];
      expect(ironMan.id, '2');
      expect(ironMan.title, 'Iron Man');
      expect(ironMan.posterImagePath, isNotEmpty);
    });

    test('getMovieById returns matching movie when id exists', () {
      final MovieRepository repository = MovieRepository();
      final Movie? movie = repository.getMovieById('1');

      expect(movie, isNotNull);
      expect(movie?.title, 'Avengers Endgame');
      expect(movie?.id, '1');
    });

    test('getMovieById returns null when id does not exist', () {
      final MovieRepository repository = MovieRepository();
      final Movie? movie = repository.getMovieById('999');

      expect(movie, isNull);
    });
  });
}
