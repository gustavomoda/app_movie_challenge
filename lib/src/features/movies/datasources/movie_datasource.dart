import '../domains/entities/movie.dart';
import 'models/movies_response.dart';

abstract class MovieDataSource {
  Future<MoviesResponseModel> getMovies({
    int page = 0,
    int limit = 99,
    bool? winner,
    int? year,
  });

  Future<WinnerByYearResponseModel> yearsWithMultipleWinners();

  Future<MinMaxWinnerIntervalProducerResponseModel> maxMinWinIntervalProducers();

  Future<StudiosWithWinCountResponseModel> studiosWithWinCount();

  Future<List<Movie>> moviesByYear({int? year, bool? winner});
}
