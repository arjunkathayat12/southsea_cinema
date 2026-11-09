class Movie {
  final String id;
  final String title;
  final String synopsis;
  final String ageRating;
  final String screeningTiming;
  final double ticketPrice;
  final String posterImagePath;

  const Movie(
      {required this.id,
      required this.title,
      required this.synopsis,
      required this.ageRating,
      required this.screeningTiming,
      required this.ticketPrice,
      required this.posterImagePath});
}
