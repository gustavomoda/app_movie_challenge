import 'package:app_movie_challenge/src/features/movies/datasources/models/movies_response.dart';
import 'package:app_movie_challenge/src/features/movies/domains/entities/movie.dart';
import 'package:app_movie_challenge/src/features/movies/domains/repositories/movies_repository.dart';
import 'package:app_movie_challenge/src/shared/exceptions/user_friendly_error.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/app_mocks.dart';
import '../../../../../fixtures/data/load_fixture.dart';

void main() {
  final movieRemoteMock = MockMovieRemoteDataSource();
  final moviesRepository = MoviesRepositoryImpl(movieRemote: movieRemoteMock);

  setUp(() {
    reset(movieRemoteMock);
  });

  group('Movie Features:', () {
    group('Domains:', () {
      group('MoviesRepository:', () {
        group('fetch movies:', () {
          test('should fetch movies and return Movies', () async {
            // Arrange
            final data =
                MoviesResponseModel.fromJson(loadFixtureFromJsonFile('remote/movies_list.json'));
            const filter = MovieFilter(
              page: 1,
              limit: 10,
              winner: true,
              year: 2023,
            );

            when(
              () => movieRemoteMock.getMovies(
                page: filter.page,
                limit: filter.limit,
                winner: filter.winner,
                year: filter.year,
              ),
            ).thenAnswer((_) async => data);

            // Act
            final result = await moviesRepository.fetch(filter);

            // Assert
            expect(result, isA<Either<UserFriendlyError, Movies>>());
            expect(result.isRight, isTrue);

            final actual = result.fold((_) => null, (value) => value);
            expect(actual, isNotNull);
            expect(actual, isA<Movies>());
            expect(actual!.lastPage, isFalse);
            expect(actual.content.length, data.content.length);
            expect(actual.content.first, data.content.first);
            expect(actual.content.last, data.content.last);
            expect(actual.totalElements, data.totalElements);
            expect(actual.totalPages, data.totalPages);
          });

          test(
              'should return a UserFriendlyError when attempting to fetch movies and a UserFriendlyError is encountered',
              () async {
            // Arrange
            final expected = Exception('Foo error message');
            const filter = MovieFilter(
              page: 1,
              limit: 10,
              winner: true,
              year: 2023,
            );

            when(
              () => movieRemoteMock.getMovies(
                page: filter.page,
                limit: filter.limit,
                winner: filter.winner,
                year: filter.year,
              ),
            ).thenAnswer((_) => throw expected);

            // Act
            final result = await moviesRepository.fetch(filter);

            // Assert
            expect(result, isA<Either<UserFriendlyError, Movies>>());
            expect(result.isLeft, isTrue);

            final response = result.fold((error) => error, (value) => null);

            expect(response, isNotNull);
            expect(response, isA<UserFriendlyError>());

            expect(response!.getCause(), expected);
          });
          test(
              'should return a UserFriendlyError when attempting to fetch movies and an uncaught exception is encountered',
              () async {
            // Arrange
            final expected = UserFriendlyError.error(
              title: 'Foo error message',
              message: 'Foo error cause',
              cause: Exception('Foo error message'),
              stackTrace: StackTrace.current,
            );

            const filter = MovieFilter(
              page: 1,
              limit: 10,
              winner: true,
              year: 2023,
            );

            when(
              () => movieRemoteMock.getMovies(
                page: filter.page,
                limit: filter.limit,
                winner: filter.winner,
                year: filter.year,
              ),
            ).thenAnswer((_) => throw expected);

            // Act
            final result = await moviesRepository.fetch(filter);

            // Assert
            expect(result, isA<Either<UserFriendlyError, Movies>>());
            expect(result.isLeft, isTrue);

            final response = result.fold((error) => error, (value) => null);

            expect(response, isNotNull);
            expect(response, isA<UserFriendlyError>());
            expect(response, same(response));
          });
        });
      });
    });
  });
}
