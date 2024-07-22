import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/exceptions/user_friendly_error.dart';
import '../entities/movie.dart';
import '../repositories/movies_repository.dart';

abstract class MinMaxWinnerIntervalProducerUseCase {
  Future<Either<UserFriendlyError, MinMaxWinnerIntervalProducer>> fetch();
}

@Injectable(as: MinMaxWinnerIntervalProducerUseCase)
class MinMaxWinnerIntervalProducerUseCaseImpl implements MinMaxWinnerIntervalProducerUseCase {
  const MinMaxWinnerIntervalProducerUseCaseImpl({
    required this.moviesRepository,
  });

  final MoviesRepository moviesRepository;

  @override
  Future<Either<UserFriendlyError, MinMaxWinnerIntervalProducer>> fetch() =>
      moviesRepository.maxMinWinIntervalProducers();
}
