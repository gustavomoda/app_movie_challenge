import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    required int id,
    required int year,
    required String title,
    required List<String> studios,
    required List<String> producers,
    required bool winner,
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}

@freezed
class MovieFilter with _$MovieFilter {
  const factory MovieFilter({
    @Default(0) int page,
    @Default(20) int limit,
    int? year,
    bool? winner,
  }) = _MovieFilter;
}

@freezed
class Movies with _$Movies {
  const factory Movies({
    @Default([]) List<Movie> content,
    @Default(0) int totalPages,
    @Default(0) int totalElements,
    @Default(true) bool lastPage,
  }) = _Movies;

  factory Movies.fromJson(Map<String, dynamic> json) => _$MoviesFromJson(json);
}
