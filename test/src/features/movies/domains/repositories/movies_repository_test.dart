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
            final data = MoviesResponseModel.fromJson(
              loadFixtureFromJsonFile('remote/movies_list.json'),
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

      group('studiosWithWinCount:', () {
        test('should fetch movies and return StudiosWithWinCount', () async {
          // Arrange
          final data = StudiosWithWinCountResponseModel.fromJson(
            loadFixtureFromJsonFile('remote/studios-with-win-count.json'),
          );

          when(
            movieRemoteMock.studiosWithWinCount,
          ).thenAnswer((_) async => data);

          // Act
          final result = await moviesRepository.studiosWithWinCount();

          // Assert
          expect(
            result,
            isA<Either<UserFriendlyError, List<StudiosWithWinCount>>>(),
          );
          expect(result.isRight, isTrue);

          final actual = result.fold((_) => null, (value) => value);
          expect(actual, isNotNull);
          expect(actual, isA<List<StudiosWithWinCount>>());
          expect(actual!.length, data.studios.length);
        });

        test(
            'should return a UserFriendlyError when attempting to request and a UserFriendlyError is encountered',
            () async {
          // Arrange
          final expected = Exception('Foo error message');

          when(
            movieRemoteMock.studiosWithWinCount,
          ).thenAnswer((_) => throw expected);

          // Act
          final result = await moviesRepository.studiosWithWinCount();

          // Assert
          expect(
            result,
            isA<Either<UserFriendlyError, List<StudiosWithWinCount>>>(),
          );
          expect(result.isLeft, isTrue);

          final response = result.fold((error) => error, (value) => null);

          expect(response, isNotNull);
          expect(response, isA<UserFriendlyError>());

          expect(response!.getCause(), expected);
        });
        test(
            'should return a UserFriendlyError when attempting to request and a UserFriendlyError is encountered',
            () async {
          // Arrange
          final expected = UserFriendlyError.error(
            title: 'Foo error message',
            message: 'Foo error cause',
            cause: Exception('Foo error message'),
            stackTrace: StackTrace.current,
          );

          when(
            movieRemoteMock.studiosWithWinCount,
          ).thenAnswer((_) => throw expected);

          // Act
          final result = await moviesRepository.studiosWithWinCount();

          // Assert
          expect(
            result,
            isA<Either<UserFriendlyError, List<StudiosWithWinCount>>>(),
          );
          expect(result.isLeft, isTrue);

          final response = result.fold((error) => error, (value) => null);

          expect(response, isNotNull);
          expect(response, isA<UserFriendlyError>());
          expect(response, same(response));
        });
      });

      group('yearsWithMultipleWinners:', () {
        test('should fetch movies and return WinnerByYearResponseModel', () async {
          // Arrange
          final data = WinnerByYearResponseModel.fromJson(
            loadFixtureFromJsonFile('remote/years-with-multiple-winners.json'),
          );

          when(
            movieRemoteMock.yearsWithMultipleWinners,
          ).thenAnswer((_) async => data);

          // Act
          final result = await moviesRepository.yearsWithMultipleWinners();

          // Assert
          expect(
            result,
            isA<Either<UserFriendlyError, List<WinnerByYear>>>(),
          );
          expect(result.isRight, isTrue);

          final actual = result.fold((_) => null, (value) => value);
          expect(actual, isNotNull);
          expect(actual, isA<List<WinnerByYear>>());
          expect(actual!.length, data.years.length);
        });

        test(
            'should return a UserFriendlyError when attempting to request and a UserFriendlyError is encountered',
            () async {
          // Arrange
          final expected = Exception('Foo error message');

          when(
            movieRemoteMock.yearsWithMultipleWinners,
          ).thenAnswer((_) => throw expected);

          // Act
          final result = await moviesRepository.yearsWithMultipleWinners();

          // Assert
          expect(result, isA<Either<UserFriendlyError, List<WinnerByYear>>>());
          expect(result.isLeft, isTrue);

          final response = result.fold((error) => error, (value) => null);

          expect(response, isNotNull);
          expect(response, isA<UserFriendlyError>());

          expect(response!.getCause(), expected);
        });
        test(
            'should return a UserFriendlyError when attempting to request and a UserFriendlyError is encountered',
            () async {
          // Arrange
          final expected = UserFriendlyError.error(
            title: 'Foo error message',
            message: 'Foo error cause',
            cause: Exception('Foo error message'),
            stackTrace: StackTrace.current,
          );

          when(
            movieRemoteMock.yearsWithMultipleWinners,
          ).thenAnswer((_) => throw expected);

          // Act
          final result = await moviesRepository.yearsWithMultipleWinners();

          // Assert
          expect(result, isA<Either<UserFriendlyError, List<WinnerByYear>>>());
          expect(result.isLeft, isTrue);

          final response = result.fold((error) => error, (value) => null);

          expect(response, isNotNull);
          expect(response, isA<UserFriendlyError>());
          expect(response, same(response));
        });
      });

      group('maxMinWinIntervalProducers:', () {
        test('should fetch movies and return MinMaxWinnerIntervalProducer', () async {
          // Arrange
          final data = MinMaxWinnerIntervalProducerResponseModel.fromJson(
            loadFixtureFromJsonFile(
              'remote/max-min-win-interval-for-producers.json',
            ),
          );

          when(
            movieRemoteMock.maxMinWinIntervalProducers,
          ).thenAnswer((_) async => data);

          // Act
          final result = await moviesRepository.maxMinWinIntervalProducers();

          // Assert
          expect(
            result,
            isA<Either<UserFriendlyError, MinMaxWinnerIntervalProducer>>(),
          );
          expect(result.isRight, isTrue);

          final actual = result.fold((_) => null, (value) => value);
          expect(actual, isNotNull);
          expect(actual, isA<MinMaxWinnerIntervalProducer>());
          expect(actual!.min.length, data.min.length);
          expect(actual.max.length, data.max.length);
        });

        test(
            'should return a UserFriendlyError when attempting to request and a UserFriendlyError is encountered',
            () async {
          // Arrange
          final expected = Exception('Foo error message');

          when(
            movieRemoteMock.maxMinWinIntervalProducers,
          ).thenAnswer((_) => throw expected);

          // Act
          final result = await moviesRepository.maxMinWinIntervalProducers();

          // Assert
          expect(
            result,
            isA<Either<UserFriendlyError, MinMaxWinnerIntervalProducer>>(),
          );
          expect(result.isLeft, isTrue);

          final response = result.fold((error) => error, (value) => null);

          expect(response, isNotNull);
          expect(response, isA<UserFriendlyError>());

          expect(response!.getCause(), expected);
        });
        test(
            'should return a UserFriendlyError when attempting to request and a UserFriendlyError is encountered',
            () async {
          // Arrange
          final expected = UserFriendlyError.error(
            title: 'Foo error message',
            message: 'Foo error cause',
            cause: Exception('Foo error message'),
            stackTrace: StackTrace.current,
          );

          when(
            movieRemoteMock.maxMinWinIntervalProducers,
          ).thenAnswer((_) => throw expected);

          // Act
          final result = await moviesRepository.maxMinWinIntervalProducers();

          // Assert
          expect(
            result,
            isA<Either<UserFriendlyError, MinMaxWinnerIntervalProducer>>(),
          );
          expect(result.isLeft, isTrue);

          final response = result.fold((error) => error, (value) => null);

          expect(response, isNotNull);
          expect(response, isA<UserFriendlyError>());
          expect(response, same(response));
        });
      });
    });
  });
}
