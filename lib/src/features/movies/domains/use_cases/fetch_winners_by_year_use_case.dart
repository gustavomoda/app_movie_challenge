import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/exceptions/user_friendly_error.dart';
import '../entities/movie.dart';
import '../repositories/movies_repository.dart';

abstract class FetchWinnersByYearUseCase {
  Future<Either<UserFriendlyError, List<WinnerByYear>>> fetch();
}

@Injectable(as: FetchWinnersByYearUseCase)
class FetchWinnersByYearUseCaseImpl implements FetchWinnersByYearUseCase {
  const FetchWinnersByYearUseCaseImpl({required this.moviesRepository});

  final MoviesRepository moviesRepository;

  @override
  Future<Either<UserFriendlyError, List<WinnerByYear>>> fetch() =>
      moviesRepository.yearsWithMultipleWinners();
}
