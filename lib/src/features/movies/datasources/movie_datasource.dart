import 'models/movies_response.dart';

abstract class MovieDataSource {
  Future<MoviesResponseModel> getMovies({
    int page = 0,
    int limit = 99,
    bool? winner,
    int? year,
  });
}
