import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/movie.dart';

class MovieProvider with ChangeNotifier {
  final ApiService api = ApiService();

  List<Movie> movies = [];
  Movie? detail;

  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchPopularMovies() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      movies = await api.getPopularMovies();
      print("Fetched ${movies.length} movies successfully");
    } catch (e) {
      movies = [];
      errorMessage = "Error: $e";
      print("Error fetchPopularMovies: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMovieDetail(int id) async {
    try {
      detail = await api.getMovieDetail(id);
      notifyListeners();
    } catch (e) {
      errorMessage = "Error loading detail: $e";
      print("Error fetchMovieDetail: $e");
    }
  }
}
