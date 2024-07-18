import '../../domains/entities/movie.dart';

abstract class MoviesEvent {
  const MoviesEvent();
}

class FetchMovieEvent extends MoviesEvent {
  const FetchMovieEvent({this.filter = const MovieFilter()});

  final MovieFilter filter;
}

class FilterMovieEvent extends MoviesEvent {
  const FilterMovieEvent({this.filter = const MovieFilter()});

  final MovieFilter filter;
}

class FetchMoreMovieEvent extends MoviesEvent {}

class RetryMovieEvent extends MoviesEvent {}
