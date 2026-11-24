import 'package:flutter/material.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/order_screen.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cinemaSurface,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  movie.posterImagePath,
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: cinemaHeaderStyle,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Age rating: ${movie.ageRating}',
                        style: const TextStyle(
                          color: cinemaFontMuted,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.synopsis,
                        style: const TextStyle(
                          color: cinemaFontMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Screening: ${movie.screeningTiming}',
                        style: const TextStyle(
                          color: cinemaFontMuted,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ticket price: ${movie.formattedPrice}',
                        style: const TextStyle(
                          color: cinemaFontMuted,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                PrimaryButton(
                  label: 'Book tickets',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return OrderScreen(movie: movie);
                        },
                      ),
                    );
                  },
                  child: const Text('Order'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
