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

@freezed
class StudiosWithWinCount with _$StudiosWithWinCount {
  const factory StudiosWithWinCount({
    required String name,
    required int winCount,
  }) = _StudiosWithWinCount;

  factory StudiosWithWinCount.fromJson(Map<String, dynamic> json) =>
      _$StudiosWithWinCountFromJson(json);
}

@freezed
class WinnerIntervalProducer with _$WinnerIntervalProducer {
  const factory WinnerIntervalProducer({
    required String producer,
    required int interval,
    required int previousWin,
    required int followingWin,
  }) = _WinnerIntervalProducer;

  factory WinnerIntervalProducer.fromJson(Map<String, dynamic> json) =>
      _$WinnerIntervalProducerFromJson(json);
}

@freezed
class WinnerByYear with _$WinnerByYear {
  const factory WinnerByYear({
    required int year,
    required int winnerCount,
  }) = _WinnerByYear;

  factory WinnerByYear.fromJson(Map<String, dynamic> json) => _$WinnerByYearFromJson(json);
}

@freezed
class MinMaxWinnerIntervalProducer with _$MinMaxWinnerIntervalProducer {
  const factory MinMaxWinnerIntervalProducer({
    required List<WinnerIntervalProducer> min,
    required List<WinnerIntervalProducer> max,
  }) = _MinMaxWinnerIntervalProducer;

  factory MinMaxWinnerIntervalProducer.fromJson(Map<String, dynamic> json) =>
      _$MinMaxWinnerIntervalProducerFromJson(json);
}
