import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../di/annotations.dart';
import '../../../../shared/exceptions/user_friendly_error.dart';
import '../../datasources/movie_datasource.dart';
import '../entities/movie.dart';

abstract class MoviesRepository {
  Future<Either<UserFriendlyError, Movies>> fetch(MovieFilter filter);
}

@Injectable(as: MoviesRepository)
class MoviesRepositoryImpl implements MoviesRepository {
  const MoviesRepositoryImpl({@remoteDataSource required this.movieRemote});

  final MovieDataSource movieRemote;

  @override
  Future<Either<UserFriendlyError, Movies>> fetch(MovieFilter filter) async {
    try {
      final result = await movieRemote.getMovies(
        page: filter.page,
        limit: filter.limit,
        winner: filter.winner,
        year: filter.year,
      );
      return Right(
        Movies(
          content: result.content,
          totalPages: result.totalPages,
          totalElements: result.totalElements,
          lastPage: result.last,
        ),
      );
    } on UserFriendlyError catch (e) {
      return Left(e);
    } catch (e, stackTrace) {
      return Left(
        UserFriendlyError.defaultFatalError(cause: e, stackTrace: stackTrace),
      );
    }
  }
}
