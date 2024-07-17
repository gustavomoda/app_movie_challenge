import 'package:freezed_annotation/freezed_annotation.dart';

part 'cache_entry.freezed.dart';
part 'cache_entry.g.dart';

const cacheTimeDefault = Duration(days: 1);

@freezed
class CacheEntry with _$CacheEntry {
  factory CacheEntry({
    required DateTime createdAt,
    required DateTime? expireAt,
    required Duration? cacheTime,
    required String? content,
  }) = _CacheEntry;

  const CacheEntry._();

  factory CacheEntry.fromJson(Map<String, Object?> json) => _$CacheEntryFromJson(json);

  factory CacheEntry.create({
    required String content,
    Duration? cacheTime = const Duration(days: 1),
  }) =>
      CacheEntry(
        createdAt: DateTime.now(),
        cacheTime: cacheTime,
        expireAt: DateTime.now().add(cacheTime ?? cacheTimeDefault),
        content: content,
      );

  bool get isExpired => expireAt == null || expireAt!.isBefore(DateTime.now());
}
