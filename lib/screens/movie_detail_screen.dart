import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int movieId = ModalRoute.of(context)!.settings.arguments as int;
    final movieProv = Provider.of<MovieProvider>(context);

    if (movieProv.detail == null || movieProv.detail!.id != movieId) {
      movieProv.fetchMovieDetail(movieId);
    }

    final detail = movieProv.detail;
    if (detail == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final posterUrl = detail.posterPath != null
        ? 'https://image.tmdb.org/t/p/w500${detail.posterPath}'
        : null;

    return Scaffold(
      appBar: AppBar(title: Text(detail.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (posterUrl != null) Image.network(posterUrl),
            const SizedBox(height: 12),
            Text(detail.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Rating: ${detail.rating}"),
            const SizedBox(height: 12),
            Text(detail.overview),
          ],
        ),
      ),
    );
  }
}
