import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../di/annotations.dart';
import '../../../../shared/exceptions/user_friendly_error.dart';
import '../../datasources/movie_datasource.dart';
import '../entities/movie.dart';

abstract class MoviesRepository {
  Future<Either<UserFriendlyError, Movies>> fetch(MovieFilter filter);

  Future<Either<UserFriendlyError, List<WinnerByYear>>> yearsWithMultipleWinners();

  Future<Either<UserFriendlyError, MinMaxWinnerIntervalProducer>> maxMinWinIntervalProducers();

  Future<Either<UserFriendlyError, List<StudiosWithWinCount>>> studiosWithWinCount();
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

  @override
  Future<Either<UserFriendlyError, List<StudiosWithWinCount>>> studiosWithWinCount() async {
    try {
      final result = await movieRemote.studiosWithWinCount();
      return Right(result.studios);
    } on UserFriendlyError catch (e) {
      return Left(e);
    } catch (e, stackTrace) {
      return Left(
        UserFriendlyError.defaultFatalError(cause: e, stackTrace: stackTrace),
      );
    }
  }

  @override
  Future<Either<UserFriendlyError, List<WinnerByYear>>> yearsWithMultipleWinners() async {
    try {
      final result = await movieRemote.yearsWithMultipleWinners();
      return Right(result.years);
    } on UserFriendlyError catch (e) {
      return Left(e);
    } catch (e, stackTrace) {
      return Left(
        UserFriendlyError.defaultFatalError(cause: e, stackTrace: stackTrace),
      );
    }
  }

  @override
  Future<Either<UserFriendlyError, MinMaxWinnerIntervalProducer>>
      maxMinWinIntervalProducers() async {
    try {
      final result = await movieRemote.maxMinWinIntervalProducers();
      return Right(
        MinMaxWinnerIntervalProducer(min: result.min, max: result.max),
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
