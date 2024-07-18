import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/exceptions/user_friendly_error.dart';
import '../entities/movie.dart';
import '../repositories/movies_repository.dart';

abstract class FetchMoviesUseCase {
  Future<Either<UserFriendlyError, Movies>> fetch(MovieFilter filter);
}

@Injectable(as: FetchMoviesUseCase)
class FetchMoviesUseCaseImpl implements FetchMoviesUseCase {
  const FetchMoviesUseCaseImpl({required this.moviesRepository});

  final MoviesRepository moviesRepository;

  @override
  Future<Either<UserFriendlyError, Movies>> fetch(MovieFilter filter) =>
      moviesRepository.fetch(filter);
}
