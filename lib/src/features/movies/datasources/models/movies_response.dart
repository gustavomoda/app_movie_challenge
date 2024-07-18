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
