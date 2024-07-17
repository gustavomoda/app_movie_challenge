import 'package:app_movie_challenge/src/shared/externals/storage/app_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../flutter_test_config.dart';

void main() {
  group('AppLocalStorage:', () {
    final mockStorage = appTestInjector.get<FlutterSecureStorage>();
    final appStorage = appTestInjector.get<AppStorage>();

    // Test for write and read with valid cache
    test('write and read string with valid cache', () async {
      const key = 'key';
      const expected = 'the string';

      when(() => mockStorage.write(key: key, value: any(named: 'value')))
          .thenAnswer((_) async => true);

      await appStorage.write(
        key: key,
        value: expected,
        cacheTime: const Duration(days: 1),
      );

      final writedValue = verify(
        () => mockStorage.write(key: key, value: captureAny(named: 'value')),
      ).captured.single;

      when(() => mockStorage.read(key: key)).thenAnswer(
        (_) => Future.value(writedValue),
      );

      final result = await appStorage.read(key: key);

      expect(result, expected);
      verify(() => mockStorage.read(key: key)).called(1);
    });

    // Test for read with expired cache
    test('read expired cache', () async {
      const key = 'key';
      const value =
          '{"cached":true,"content":{"createdAt":"2024-04-23T10:14:20.437945","expireAt":"2024-04-23T10:14:20.437948","cacheTime":1,"content":"the string"},"storageAt":"2024-04-23T10:14:20.440141"}';

      when(() => mockStorage.read(key: key)).thenAnswer((_) async => value);

      final result = await appStorage.read(key: key);

      expect(result, isNull);
      verify(() => mockStorage.read(key: key)).called(1);
      verify(() => mockStorage.delete(key: key)).called(1);
    });

    // Test for read with no cache
    test('read with no cache', () async {
      const key = 'key';
      const expected = 'the string';

      when(() => mockStorage.write(key: key, value: any(named: 'value')))
          .thenAnswer((_) async => true);

      await appStorage.write(key: key, value: expected);

      final writedValue = verify(
        () => mockStorage.write(key: key, value: captureAny(named: 'value')),
      ).captured.single;

      when(() => mockStorage.read(key: key)).thenAnswer(
        (_) => Future.value(writedValue),
      );

      final result = await appStorage.read(key: key);

      expect(result, expected);
      verify(() => mockStorage.read(key: key)).called(1);
      verifyNever(() => mockStorage.delete(key: key));
    });

    // Test for delete
    test('delete a key', () async {
      const key = 'key';

      when(() => mockStorage.delete(key: key)).thenAnswer((_) async => true);

      await appStorage.delete(key: key);

      verify(() => mockStorage.delete(key: key)).called(1);
    });

    // Test for delete all
    test('delete all keys', () async {
      when(mockStorage.deleteAll).thenAnswer((_) async => true);

      await appStorage.deleteAll();

      verify(mockStorage.deleteAll).called(1);
    });
  });
}
