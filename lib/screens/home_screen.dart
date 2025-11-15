import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_card.dart';
import '../providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final movieProv = Provider.of<MovieProvider>(context, listen: false);
    movieProv.fetchPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    final movieProv = Provider.of<MovieProvider>(context);
    final authProv = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Movies"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authProv.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: movieProv.isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.62,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: movieProv.movies.length,
              itemBuilder: (context, index) {
                final movie = movieProv.movies[index];
                return MovieCard(
                  movie: movie,
                  onTap: () {
                    movieProv.fetchMovieDetail(movie.id);
                    Navigator.pushNamed(context, '/detail', arguments: movie.id);
                  },
                );
              },
            ),
    );
  }
}
