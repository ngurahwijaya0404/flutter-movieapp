import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;
  const MovieCard({super.key, required this.movie, this.onTap});

  @override
  Widget build(BuildContext context) {
    final posterUrl = movie.posterPath != null
        ? 'https://image.tmdb.org/t/p/w300${movie.posterPath}'
        : null;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            posterUrl != null
                ? Image.network(posterUrl, height: 220, width: double.infinity, fit: BoxFit.cover)
                : Container(height: 220, color: Colors.grey[300], child: const Icon(Icons.movie, size: 60)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("Rating: ${movie.rating}", style: const TextStyle(fontSize: 12)),
            )
          ],
        ),
      ),
    );
  }
}
