import 'package:app_movie_challenge/src/shared/externals/http_client/http_interceptors.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/app_mocks.dart';
import '../../../../fixtures/extenal_mock.dart';

void main() {
  final mockRequestHandler = MockRequestInterceptorHandler();
  final mockResponseHandler = MockResponseInterceptorHandler();
  final mockErrorHandler = MockErrorInterceptorHandler();
  final mockAppLogger = MockAppLogger();
  final interceptor = AppHttpInterceptors(mockAppLogger);

  group('AppHttpClient:', () {
    setUp(() {
      reset(mockRequestHandler);
      reset(mockResponseHandler);
      reset(mockErrorHandler);
      reset(mockAppLogger);
    });

    group('AppHttpInterceptors:', () {
      test('onRequest should log request details', () async {
        // Arrange
        final options = RequestOptions(path: '/test');

        // Act
        await interceptor.onRequest(options, mockRequestHandler);

        verify(() => mockAppLogger.d(any<String>())).called(1);
      });

      test('onResponse should log response details', () {
        // Arrange
        final response = Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 200,
        );

        // Act
        interceptor.onResponse(response, mockResponseHandler);

        // Assert
        verify(() => mockAppLogger.d(any<String>())).called(1);
      });

      test('onError should log error details', () {
        // Arrange
        final error = DioException(
          requestOptions: RequestOptions(path: '/test'),
          error: 'Error',
        );

        // Act
        interceptor.onError(error, mockErrorHandler);

        // Assert
        verify(() => mockAppLogger.d(any<String>())).called(1);
      });
    });
  });
}
