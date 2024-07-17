import 'dart:convert';

import 'package:app_movie_challenge/src/di/app_injector.dart';
import 'package:app_movie_challenge/src/shared/exceptions/user_friendly_error.dart';
import 'package:app_movie_challenge/src/shared/externals/app_logger.dart';
import 'package:app_movie_challenge/src/shared/externals/http_client/client.dart';
import 'package:app_movie_challenge/src/shared/externals/http_client/http_interceptors.dart';
import 'package:app_movie_challenge/src/shared/externals/http_client/options.dart';
import 'package:dio/dio.dart' as external_dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements external_dio.Dio {}

void main() {
  const path = 'test/path';

  final mockDio = MockDio();
  final httpClient = AppHttpClientImpl(
    options: ClientOptions(
      baseUrl: 'http://example.com',
      connectTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      globalTimeout: const Duration(seconds: 10),
    ),
    dio: mockDio,
  );

  group('AppHttpClient:', () {
    setUp(() {
      reset(mockDio);
    });

    test('should create a default Dio instance with the given options', () {
      final options = ClientOptions(
        baseUrl: 'http://example.com',
        connectTimeout: const Duration(seconds: 5),
        sendTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        globalTimeout: const Duration(seconds: 10),
      );
      final instance = AppHttpClientImpl(
        options: options,
      );

      expect(
        instance.dioForTests.options.baseUrl,
        equals('http://example.com/'),
      );
      expect(
        instance.dioForTests.options.connectTimeout,
        same(options.connectTimeout),
      );
      expect(
        instance.dioForTests.options.sendTimeout,
        same(options.sendTimeout),
      );
      expect(
        instance.dioForTests.options.receiveTimeout,
        same(options.receiveTimeout),
      );
    });

    test('should add an interceptor to the Dio interceptors list', () {
      final appHttpInterceptors = AppHttpInterceptors(appInjector.get<AppLogger>());
      final instance = AppHttpClientImpl(
        options: ClientOptions(
          baseUrl: 'http://example.com',
          connectTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
          globalTimeout: const Duration(seconds: 10),
        ),
      )..addInterceptor(appHttpInterceptors);

      expect(
        instance.dioForTests.interceptors.last,
        equals(appHttpInterceptors),
      );
    });

    test('should return a Response on successful GET', () async {
      // Prepare the Dio response
      final response = external_dio.Response(
        requestOptions: external_dio.RequestOptions(path: path),
        data: 'Successful data',
        statusCode: 200,
        statusMessage: 'OK',
      );

      // Setup the mock to return the prepared response
      when(() => mockDio.get<String>(any())).thenAnswer((_) async => response);

      // Call the method
      final result = await httpClient.get<String>(path);

      // Verify the results
      expect(result.data, equals('Successful data'));
      expect(result.statusCode, equals(200));
      expect(result.isOk, isTrue);
    });

    test('should return a Response on successful GET when List responses', () async {
      final data = [
        {'id': 1, 'name': 'John'},
        {'id': 2, 'name': 'Jane'},
      ];

      final response = external_dio.Response<String>(
        requestOptions: external_dio.RequestOptions(path: path),
        data: jsonEncode(data),
        statusCode: 200,
        statusMessage: 'OK',
      );

      // Setup the mock to return the prepared response
      when(() => mockDio.get<String>(any())).thenAnswer((_) async => response);

      // Call the method
      final result = await httpClient.getAsList<Map<String, dynamic>>(path);

      // Verify the results
      expect(result.data, isA<List>());
      expect(result.data, equals(data));
      expect(result.statusCode, equals(200));
      expect(result.isOk, isTrue);
    });

    test('should throw AppHttpClientException on Dio exception', () {
      when(
        // ignore: discarded_futures
        () => mockDio.get<String>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async {
        throw external_dio.DioException(
          requestOptions: external_dio.RequestOptions(
            path: path,
          ),
          response: external_dio.Response(
            requestOptions: external_dio.RequestOptions(path: path),
            statusCode: 400,
            data: 'Failed request',
          ),
          type: external_dio.DioExceptionType.badResponse,
        );
      });

      expect(
        () async => httpClient.get<String>(path),
        throwsA(isA<UserFriendlyError>()),
      );
    });

    test('should throw uncaught Exception', () {
      when(
        // ignore: discarded_futures
        () => mockDio.get<String>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async {
        throw Exception('Uncaught exception');
      });

      expect(
        () async => httpClient.get<String>(path),
        throwsA(isA<UserFriendlyError>()),
      );
    });
  });
}
