// ignore_for_file: discarded_futures, avoid_redundant_argument_values

import 'package:app_movie_challenge/src/features/movies/domains/entities/movie.dart';
import 'package:app_movie_challenge/src/features/movies/presenters/controllers/movies_bloc.dart';
import 'package:app_movie_challenge/src/shared/exceptions/user_friendly_error.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/app_mocks.dart';

void main() {
  final movies = (
    first: Movies(
      totalPages: 1,
      lastPage: false,
      content: <Movie>[MockMovie(), MockMovie()],
    ),
    second: Movies(
      totalPages: 2,
      lastPage: false,
      content: <Movie>[MockMovie(), MockMovie()],
    ),
    last: Movies(
      totalPages: 3,
      lastPage: true,
      content: <Movie>[MockMovie()],
    ),
  );
  const filters = (
    first: MovieFilter(page: 0, limit: 10, year: 2020, winner: true),
    second: MovieFilter(page: 1, limit: 10, year: 2020, winner: true),
    last: MovieFilter(page: 2, limit: 10, year: 2020, winner: true),
  );

  final mockFetchMoviesUseCase = MockFetchMoviesUseCase();
  final mockLogger = MockAppLogger();
  var moviesBloc = MoviesBloc(
    fetchMovies: mockFetchMoviesUseCase,
    logger: mockLogger,
  );

  const error = UserFriendlyError.error(
    title: 'Error',
    message: 'Failed to fetch movies',
    cause: null,
    stackTrace: null,
  );

  setUp(() {
    reset(mockFetchMoviesUseCase);
    reset(mockLogger);
    moviesBloc = MoviesBloc(
      fetchMovies: mockFetchMoviesUseCase,
      logger: mockLogger,
    );
  });

  tearDown(() async {
    await moviesBloc.close();
  });

  group('Movie Features:', () {
    group('Presenters:', () {
      group('MovieBloc Contollers:', () {
        blocTest<MoviesBloc, MoviesState>(
          'emits [FetchingMoviesState, FetchedMoviesState] and reset movies when FetchMovieEvent is added and fetch is successful for the first page',
          build: () {
            when(
              () => mockFetchMoviesUseCase.fetch(filters.first),
            ).thenAnswer((_) async => Right(movies.first));
            return moviesBloc;
          },
          act: (bloc) {
            bloc.add(FetchMovieEvent(filter: filters.first));
          },
          expect: () => [
            FetchingMoviesState(
              movies: const Movies(),
              filter: filters.first,
            ),
            FetchedMoviesState(
              movies: movies.first,
              filter: filters.first,
            ),
          ],
        );

        blocTest<MoviesBloc, MoviesState>(
          'emits [FetchingMoviesState, FetchedMoviesState] and preserves movies when FetchMovieEvent is added and fetch is successful for the page greater than zero',
          build: () {
            when(
              () => mockFetchMoviesUseCase.fetch(filters.second),
            ).thenAnswer((_) async => Right(movies.second));
            return moviesBloc;
          },
          act: (bloc) {
            bloc.add(FetchMovieEvent(filter: filters.second));
          },
          seed: () => FetchedMoviesState(
            movies: movies.first,
            filter: filters.first,
          ),
          expect: () => [
            FetchingMoviesState(movies: movies.first, filter: filters.second),
            FetchedMoviesState(movies: movies.second, filter: filters.second),
          ],
        );

        blocTest<MoviesBloc, MoviesState>(
          'emits [FetchingMoviesState, FailedFetchMoviesState] when FetchMovieEvent is added and fetch fails',
          build: () {
            when(
              () => mockFetchMoviesUseCase.fetch(filters.first),
            ).thenAnswer((_) async => const Left(error));

            return moviesBloc;
          },
          act: (bloc) => bloc.add(FetchMovieEvent(filter: filters.first)),
          expect: () => [
            FetchingMoviesState(
              movies: const Movies(),
              filter: filters.first,
            ),
            FailedFetchMoviesState(
              error: error,
              movies: const Movies(),
              filter: filters.first,
            ),
          ],
        );

        blocTest<MoviesBloc, MoviesState>(
          'emits [FetchingMoviesState, FetchedMoviesState] when FetchMoreMovieEvent is added and more movies are fetched',
          build: () {
            when(
              () => mockFetchMoviesUseCase.fetch(filters.first),
            ).thenAnswer((_) async => const Left(error));

            return moviesBloc;
          },
          act: (bloc) => bloc.add(FetchMovieEvent(filter: filters.first)),
          expect: () => [
            FetchingMoviesState(
              movies: const Movies(),
              filter: filters.first,
            ),
            FailedFetchMoviesState(
              error: error,
              movies: const Movies(),
              filter: filters.first,
            ),
          ],
        );

        blocTest<MoviesBloc, MoviesState>(
          "emits [FetchingMoviesState, FetchedMoviesState] when FetchMoreMovieEvent is added and fetches movies if it's not the last page",
          build: () {
            when(
              () => mockFetchMoviesUseCase.fetch(filters.last),
            ).thenAnswer((_) async => Right(movies.last));
            return moviesBloc;
          },
          act: (bloc) => bloc.add(FetchMoreMovieEvent()),
          seed: () => FetchedMoviesState(
            movies: movies.second,
            filter: filters.second,
          ),
          expect: () => [
            FetchingMoviesState(movies: movies.second, filter: filters.last),
            FetchedMoviesState(movies: movies.last, filter: filters.last),
          ],
        );
      });

      blocTest<MoviesBloc, MoviesState>(
        'Not emits events when FetchMoreMovieEvent is added and no more pages',
        build: () => moviesBloc,
        act: (bloc) => bloc.add(FetchMoreMovieEvent()),
        seed: () => FetchedMoviesState(
          movies: movies.last,
          filter: filters.last,
        ),
        expect: () => [],
      );
    });

    blocTest<MoviesBloc, MoviesState>(
      'emits [FetchingMoviesState, FetchedMoviesState] when FilterMovieEvent is added and movies are fetched with new filter',
      build: () {
        when(
          () => mockFetchMoviesUseCase.fetch(filters.first),
        ).thenAnswer((_) async => Right(movies.first));
        return moviesBloc;
      },
      act: (bloc) => bloc.add(FetchMovieEvent(filter: filters.first)),
      seed: () => FetchingMoviesState(
        movies: movies.last,
        filter: filters.second,
      ),
      expect: () => [
        FetchingMoviesState(
          movies: const Movies(),
          filter: filters.first,
        ),
        FetchedMoviesState(
          movies: movies.first,
          filter: filters.first,
        ),
      ],
    );
  });
}
