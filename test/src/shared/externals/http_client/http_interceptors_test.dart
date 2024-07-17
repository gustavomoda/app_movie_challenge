import 'package:app_movie_challenge/src/shared/externals/app_logger.dart';
import 'package:app_movie_challenge/src/shared/externals/http_client/http_interceptors.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAppLogger extends Mock implements AppLogger {}

class MockRequestInterceptorHandler extends Mock implements RequestInterceptorHandler {}

class MockResponseInterceptorHandler extends Mock implements ResponseInterceptorHandler {}

class MockErrorInterceptorHandler extends Mock implements ErrorInterceptorHandler {}

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
        final options = RequestOptions(path: '/test');

        await interceptor.onRequest(options, mockRequestHandler);

        verify(() => mockAppLogger.d(any<String>())).called(1);
      });

      test('onResponse should log response details', () {
        final response = Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 200,
        );

        interceptor.onResponse(response, mockResponseHandler);

        verify(() => mockAppLogger.d(any<String>())).called(1);
      });

      test('onError should log error details', () {
        final error = DioException(
          requestOptions: RequestOptions(path: '/test'),
          error: 'Error',
        );

        interceptor.onError(error, mockErrorHandler);

        verify(() => mockAppLogger.d(any<String>())).called(1);
      });
    });
  });
}
