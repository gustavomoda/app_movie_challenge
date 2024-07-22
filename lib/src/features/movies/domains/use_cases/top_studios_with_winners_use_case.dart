import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/exceptions/user_friendly_error.dart';
import '../entities/movie.dart';
import '../repositories/movies_repository.dart';

abstract class TopStudiosWithWinnersUseCase {
  Future<Either<UserFriendlyError, List<StudiosWithWinCount>>> fetch();
}

@Injectable(as: TopStudiosWithWinnersUseCase)
class TopStudiosWithWinnersUseCaseImpl implements TopStudiosWithWinnersUseCase {
  const TopStudiosWithWinnersUseCaseImpl({required this.moviesRepository});

  final MoviesRepository moviesRepository;

  @override
  Future<Either<UserFriendlyError, List<StudiosWithWinCount>>> fetch() async {
    final result = await moviesRepository.studiosWithWinCount();
    return result.fold(Left.new, (value) => Right(value.sublist(0, 3)));
  }
}
