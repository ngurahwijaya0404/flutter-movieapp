import 'package:dio/dio.dart';
import '../config/constants.dart';
import '../models/movie.dart';

class ApiService {
  final Dio dio = Dio();

  Future<List<Movie>> getPopularMovies() async {
    final response = await dio.get(
      "${AppConfig.tmdbBaseUrl}movie/popular",
      queryParameters: {
        "api_key": AppConfig.tmdbApiKey,
      },
    );

    List results = response.data["results"] ?? [];
    return results.map((e) => Movie.fromJson(e)).toList();
  }

  Future<Movie> getMovieDetail(int id) async {
    final response = await dio.get(
      "${AppConfig.tmdbBaseUrl}movie/$id",
      queryParameters: {
        "api_key": AppConfig.tmdbApiKey,
      },
    );

    return Movie.fromJson(response.data);
  }
}
