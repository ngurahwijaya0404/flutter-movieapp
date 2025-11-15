import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/movie.dart';

class MovieProvider with ChangeNotifier {
  final ApiService api = ApiService();

  List<Movie> movies = [];
  Movie? detail;

  bool isLoading = false;

  Future<void> fetchPopularMovies() async {
    isLoading = true;
    notifyListeners();

    try {
      movies = await api.getPopularMovies();
    } catch (e) {
      movies = [];
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
      print("Error fetchMovieDetail: $e");
    }
  }
}
