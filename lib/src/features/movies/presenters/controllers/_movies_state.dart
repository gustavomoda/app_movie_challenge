import 'package:equatable/equatable.dart';
import '../../../../shared/exceptions/user_friendly_error.dart';
import '../../domains/entities/movie.dart';

abstract class MoviesState extends Equatable {
  const MoviesState({required this.movies, this.filter = const MovieFilter()});

  final Movies movies;
  final MovieFilter filter;

  @override
  List<Object?> get props => [movies, filter];
}

class InertMoviesState extends MoviesState {
  const InertMoviesState({required super.movies, required super.filter});

  @override
  List<Object?> get props => [movies, filter];
}

class FetchingMoviesState extends MoviesState {
  const FetchingMoviesState({required super.movies, required super.filter});

  @override
  List<Object?> get props => [movies, filter];
}

class FetchedMoviesState extends MoviesState {
  const FetchedMoviesState({
    required super.movies,
    required super.filter,
  });

  @override
  List<Object?> get props => [movies, filter];
}

class FailedFetchMoviesState extends MoviesState {
  const FailedFetchMoviesState({
    required this.error,
    required super.movies,
    required super.filter,
  });

  final UserFriendlyError error;

  @override
  List<Object?> get props => [error, movies, filter];
}
