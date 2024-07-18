import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/externals/app_logger.dart';
import '../../domains/entities/movie.dart';
import '../../domains/use_cases/fetch_movies_use_case.dart';
import '_movies_event.dart';
import '_movies_state.dart';

export '_movies_event.dart';
export '_movies_state.dart';

@injectable
class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc({
    required this.logger,
    required this.fetchMovies,
  }) : super(const InertMoviesState(movies: Movies(), filter: MovieFilter())) {
    on<FetchMovieEvent>(_onFetchMovieEvent);
    on<FetchMoreMovieEvent>(_onFetchMoreMovieEvent);
    on<RetryMovieEvent>(_onRetryMovieEvent);
    on<FilterMovieEvent>(_onFilterMovieEvent);
  }

  final AppLogger logger;
  final FetchMoviesUseCase fetchMovies;

  Future<FutureOr<void>> _onFetchMovieEvent(
    FetchMovieEvent event,
    Emitter<MoviesState> emit,
  ) async {
    var currentMovies = state.movies;

    if (event.filter.page == 0) {
      currentMovies = const Movies();
    }

    emit(FetchingMoviesState(movies: currentMovies, filter: event.filter));

    final result = await fetchMovies.fetch(event.filter);
    result.fold(
      (error) => emit(
        FailedFetchMoviesState(
          error: error,
          filter: event.filter,
          movies: state.movies,
        ),
      ),
      (value) => emit(
        FetchedMoviesState(movies: value, filter: event.filter),
      ),
    );
  }

  FutureOr<void> _onFetchMoreMovieEvent(
    FetchMoreMovieEvent event,
    Emitter<MoviesState> emit,
  ) {
    if (!state.movies.lastPage) {
      add(
        FetchMovieEvent(
          filter: state.filter.copyWith(page: state.filter.page + 1),
        ),
      );
    }
  }

  FutureOr<void> _onRetryMovieEvent(
    RetryMovieEvent event,
    Emitter<MoviesState> emit,
  ) {
    add(FetchMovieEvent(filter: state.filter));
  }

  FutureOr<void> _onFilterMovieEvent(
    FilterMovieEvent event,
    Emitter<MoviesState> emit,
  ) {
    add(FetchMovieEvent(filter: event.filter.copyWith(page: 0)));
  }
}
