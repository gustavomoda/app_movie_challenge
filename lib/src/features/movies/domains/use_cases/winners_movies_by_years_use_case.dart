import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/exceptions/user_friendly_error.dart';
import '../entities/movie.dart';
import '../repositories/movies_repository.dart';

abstract class WinnersMoviesByYearsUseCase {
  Future<Either<UserFriendlyError, List<Movie>>> fetch({required int year});
}

@Injectable(as: WinnersMoviesByYearsUseCase)
class WinnersMoviesByYearsUseCaseImpl implements WinnersMoviesByYearsUseCase {
  const WinnersMoviesByYearsUseCaseImpl({required this.moviesRepository});

  final MoviesRepository moviesRepository;

  @override
  Future<Either<UserFriendlyError, List<Movie>>> fetch({required int year}) =>
      moviesRepository.moviesByYear(year: year, winner: true);
}
