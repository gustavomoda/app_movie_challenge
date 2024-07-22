import '../../../../shared/externals/http_client/client.dart';
import '../../domains/entities/movie.dart';
import '../models/movies_response.dart';
import '../movie_datasource.dart';

class MovieRemoteDataSource implements MovieDataSource {
  const MovieRemoteDataSource({required this.client});

  final AppHttpClient client;

  @override
  Future<MoviesResponseModel> getMovies({
    int page = 0,
    int limit = 99,
    bool? winner,
    int? year,
  }) async {
    final response = await client.get<MoviesResponseModel>(
      '',
      queryParameters: {
        'page': page,
        'size': limit,
        'winner': winner,
        'year': year,
      },
      fromJson: MoviesResponseModel.fromJson,
    );
    return response.data!;
  }

  @override
  Future<MinMaxWinnerIntervalProducerResponseModel> maxMinWinIntervalProducers() async {
    final response = await client.get<MinMaxWinnerIntervalProducerResponseModel>(
      '',
      queryParameters: {'projection': 'max-min-win-interval-for-producers'},
      fromJson: MinMaxWinnerIntervalProducerResponseModel.fromJson,
    );
    return response.data!;
  }

  @override
  Future<StudiosWithWinCountResponseModel> studiosWithWinCount() async {
    final response = await client.get<StudiosWithWinCountResponseModel>(
      '',
      queryParameters: {'projection': 'studios-with-win-count'},
      fromJson: StudiosWithWinCountResponseModel.fromJson,
    );
    return response.data!;
  }

  @override
  Future<WinnerByYearResponseModel> yearsWithMultipleWinners() async {
    final response = await client.get<WinnerByYearResponseModel>(
      '',
      queryParameters: {'projection': 'years-with-multiple-winners'},
      fromJson: WinnerByYearResponseModel.fromJson,
    );
    return response.data!;
  }

  @override
  Future<List<Movie>> moviesByYear({int? year, bool? winner}) async {
    final response = await client.getAsList<Movie>(
      '',
      queryParameters: {
        'winner': winner,
        'year': year,
      },
      fromJson: Movie.fromJson,
    );
    return response.data!;
  }
}
