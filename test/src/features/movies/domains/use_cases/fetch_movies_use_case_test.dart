import 'package:app_movie_challenge/src/features/movies/domains/entities/movie.dart';
import 'package:app_movie_challenge/src/features/movies/domains/use_cases/fetch_movies_use_case.dart';
import 'package:app_movie_challenge/src/shared/exceptions/user_friendly_error.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/app_mocks.dart';

void main() {
  final moviesRepsitoryMock = MockMoviesRepository();
  final fetchMovies = FetchMoviesUseCaseImpl(moviesRepository: moviesRepsitoryMock);

  setUp(() {
    reset(moviesRepsitoryMock);
  });
  group('Movie Features:', () {
    group('Domains:', () {
      group('MoviesRepository:', () {
        group('Fetch Movies:', () {
          test('should execute the fetch function of the repository when fetch for movies',
              () async {
            // Arrange
            const filter = MovieFilter();
            const expected = Movies();

            when(
              () => fetchMovies.fetch(filter),
            ).thenAnswer((_) async => const Right(expected));

            // Act
            final result = await moviesRepsitoryMock.fetch(filter);

            // Assert
            expect(result, isA<Either<UserFriendlyError, Movies>>());
            expect(result.isRight, isTrue);

            final actual = result.fold((_) => null, (value) => value);
            expect(actual, same(expected));
          });
        });
      });
    });
  });
}
