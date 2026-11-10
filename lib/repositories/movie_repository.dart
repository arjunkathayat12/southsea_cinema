import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie> getMovies() {
    return const [
      Movie(
        id: 1,
        title: 'Avengers Endgame',
        synopsis:
            'After Thanos, an intergalactic warlord, disintegrates half of the universe, the Avengers must reunite and assemble again to reinvigorate their trounced allies and restore balance.',
        ageRating: '12A',
        screeningTiming: '3h 5m',
        ticketPrice: 12.50,
        posterImagePath: 'assets/images/Avengers Endgame.jpg',
      ),
      Movie(
        id: 2,
        title: 'Iron Man',
        synopsis:
            'When Tony Stark, an industrialist, is captured, he constructs a high-tech armoured suit to escape. Once he manages to escape, he decides to use his suit to fight against evil forces to save the world.',
        ageRating: '12A',
        screeningTiming: '2h 6m',
        ticketPrice: 10.50,
        posterImagePath: 'assets/images/Iron Man.jpg',
      ),
    ];
  }
}
