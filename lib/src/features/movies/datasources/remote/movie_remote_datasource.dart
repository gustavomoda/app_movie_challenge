import '../../../../shared/externals/http_client/client.dart';
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
}
