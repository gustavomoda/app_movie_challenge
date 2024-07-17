import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart' as lib;
import 'package:injectable/injectable.dart';

import '../app_logger.dart';
import 'cache_entry.dart';

String _computeKey(String key, Map<String, dynamic> params) {
  final keys = params.entries
      .map((e) => '${e.key}-${e.value}')
      .reduce((value, element) => '$value-$element');
  return '$key-$keys';
}

class _Record {
  const _Record({
    required this.cached,
    required this.content,
    required this.storageAt,
  });

  _Record.fromJson(Map<String, dynamic> json)
      : this(
          cached: (json['cached'] ?? 'false') as bool,
          content: json['content'],
          storageAt: DateTime.parse(json['storageAt'] as String),
        );

  final bool cached;
  final dynamic content;
  final DateTime storageAt;

  Map<String, dynamic> toJson() => {
        'cached': cached,
        'content': content,
        'storageAt': storageAt.toIso8601String(),
      };

  @override
  String toString() => '_Record{cached: $cached, content: $content, storageAt: $storageAt}';
}

abstract class AppStorage {
  Future<void> write({
    required String key,
    required String value,
    Duration? cacheTime,
  });

  Future<void> writeAsJson({
    required String key,
    required Object value,
    Duration? cacheTime,
  });

  Future<String?> read({required String key});

  Future<Object?> readAsJson({required String key});

  Future<void> delete({required String key});

  Future<void> deleteAll();

  Future<void> deleteAllCache();

  String computeKey(String key, Map<String, dynamic> params);
}

@LazySingleton(as: AppStorage)
class AppStorageImpl implements AppStorage {
  AppStorageImpl({
    required this.flutterSecureStorage,
    required AppLogger logger,
  }) : _logger = logger;

  final lib.FlutterSecureStorage flutterSecureStorage;
  final AppLogger _logger;

  @override
  Future<void> write({
    required String key,
    required String value,
    Duration? cacheTime,
  }) async {
    _logger.d(
      '[AppStorage] write: key=$key, value=$value, cacheTime=$cacheTime',
    );
    final record = _Record(
      cached: cacheTime != null,
      content: cacheTime != null ? CacheEntry.create(content: value).toJson() : value,
      storageAt: DateTime.now(),
    );
    _logger.d(
      '[AppStorage] write: key=$key, value=$record, cacheTime=$cacheTime',
    );
    return flutterSecureStorage.write(
      key: key,
      value: jsonEncode(record.toJson()),
    );
  }

  @override
  Future<void> writeAsJson({
    required String key,
    required Object value,
    Duration? cacheTime,
  }) =>
      write(
        key: key,
        value: jsonEncode(value),
        cacheTime: cacheTime,
      );

  @override
  Future<String?> read({required String key}) async {
    _logger.d('[AppStorage] read: key=$key');
    try {
      final data = await flutterSecureStorage.read(key: key);
      if (data == null || data.isEmpty) {
        _logger.d('[AppStorage] read: key=$key, data is empty');
        return data;
      }

      final record = _Record.fromJson(jsonDecode(data));
      _logger.d('[AppStorage] read: key=$key, record=$record');

      if (record.cached) {
        final cachedData = CacheEntry.fromJson(record.content);
        _logger.d('[AppStorage] read: key=$key, cachedData=$cachedData');
        if (cachedData.isExpired) {
          _logger.d('[AppStorage] read: key=$key, cachedData is expired');
          await delete(key: key);
          return null;
        }
        return cachedData.content;
      }

      return record.content;
    } catch (e) {
      _logger.d('[AppStorage] read: key=$key, error=$e');
      return null;
    }
  }

  @override
  Future<Object?> readAsJson({required String key}) async {
    final data = await read(key: key);
    if (data == null) {
      return null;
    }
    return jsonDecode(data);
  }

  @override
  Future<void> delete({required String key}) async => flutterSecureStorage.delete(key: key);

  @override
  Future<void> deleteAll() async => flutterSecureStorage.deleteAll();

  @override
  Future<void> deleteAllCache() async {
    final all = flutterSecureStorage.readAll().asStream();
    await all.forEach((element) async {
      element.forEach((key, value) async {
        final record = _Record.fromJson(jsonDecode(value));
        if (record.cached) {
          _logger.d('[AppStorage] Deleting: key=$key');
          await delete(key: key);
        }
      });
    });
  }

  @override
  String computeKey(String key, Map<String, dynamic> params) => _computeKey(key, params);
}
