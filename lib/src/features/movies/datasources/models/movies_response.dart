import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domains/entities/movie.dart';
import 'pageable_model.dart';

part 'movies_response.freezed.dart';
part 'movies_response.g.dart';

@freezed
class MoviesResponseModel with _$MoviesResponseModel {
  const factory MoviesResponseModel({
    required List<Movie> content,
    required int totalPages,
    required int totalElements,
    required bool last,
    required int size,
    required int number,
    required SortModel sort,
    required bool first,
    required int numberOfElements,
    required bool empty,
  }) = _MoviesResponseModel;

  factory MoviesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MoviesResponseModelFromJson(json);
}

@freezed
class StudiosWithWinCountResponseModel with _$StudiosWithWinCountResponseModel {
  const factory StudiosWithWinCountResponseModel({
    required List<StudiosWithWinCount> studios,
  }) = _StudiosWithWinCountResponseModel;

  factory StudiosWithWinCountResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StudiosWithWinCountResponseModelFromJson(json);
}

@freezed
class MinMaxWinnerIntervalProducerResponseModel with _$MinMaxWinnerIntervalProducerResponseModel {
  const factory MinMaxWinnerIntervalProducerResponseModel({
    required List<WinnerIntervalProducer> min,
    required List<WinnerIntervalProducer> max,
  }) = _MinMaxWinnerIntervalProducerResponseModel;

  factory MinMaxWinnerIntervalProducerResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MinMaxWinnerIntervalProducerResponseModelFromJson(json);
}

@freezed
class WinnerByYearResponseModel with _$WinnerByYearResponseModel {
  const factory WinnerByYearResponseModel({
    required List<WinnerByYear> years,
  }) = _WinnerByYearResponseModel;

  factory WinnerByYearResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WinnerByYearResponseModelFromJson(json);
}
