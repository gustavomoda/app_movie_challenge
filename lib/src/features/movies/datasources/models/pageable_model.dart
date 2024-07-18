import 'package:freezed_annotation/freezed_annotation.dart';

part 'pageable_model.freezed.dart';
part 'pageable_model.g.dart';

@freezed
class SortModel with _$SortModel {
  const factory SortModel({
    required bool unsorted,
    required bool sorted,
    required bool empty,
  }) = _SortModel;

  factory SortModel.fromJson(Map<String, dynamic> json) => _$SortModelFromJson(json);
}

@freezed
class PageableModel with _$PageableModel {
  const factory PageableModel({
    required int offset,
    required int pageSize,
    required int pageNumber,
    required bool paged,
    required bool unpaged,
  }) = _PageableModel;

  factory PageableModel.fromJson(Map<String, dynamic> json) => _$PageableModelFromJson(json);
}
