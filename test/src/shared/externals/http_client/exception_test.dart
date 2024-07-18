import 'package:app_movie_challenge/src/shared/externals/http_client/exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppHttpClient:', () {
    group('AppHttpClientException:', () {
      test('should handle connection timeout DioException', () {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.connectionTimeout,
          error: 'Connection timeout occurred',
        );

        final exception = AppHttpClientException.fromDioException(dioException);

        // Act and Assert
        expect(exception.errorType, ErrorType.connectionTimeout);
        expect(exception.statusCode, 500);
        expect(exception.statusMessage, '');
      });

      test('should handle bad certificate DioException', () {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.badCertificate,
          error: 'Invalid certificate',
        );

        final exception = AppHttpClientException.fromDioException(dioException);

        // Act and Assert
        expect(exception.errorType, ErrorType.badCertificate);
        expect(exception.statusCode, 500);
        expect(exception.statusMessage, '');
      });

      test('should handle bad response DioException', () {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.badResponse,
          error: 'Bad Response',
        );

        final exception = AppHttpClientException.fromDioException(dioException);

        // Act and Assert
        expect(exception.errorType, ErrorType.badResponse);
        expect(exception.statusCode, 500);
        expect(exception.statusMessage, '');
      });

      test('should handle cancel DioException', () {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.cancel,
          error: 'Canceled',
        );

        final exception = AppHttpClientException.fromDioException(dioException);

        // Act and Assert
        expect(exception.errorType, ErrorType.cancel);
        expect(exception.statusCode, 500);
        expect(exception.statusMessage, '');
      });

      test('should handle connectionError DioException', () {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.connectionError,
          error: 'Connection Error',
        );

        final exception = AppHttpClientException.fromDioException(dioException);

        // Act and Assert
        expect(exception.errorType, ErrorType.connectionError);
        expect(exception.statusCode, 500);
        expect(exception.statusMessage, '');
      });

      test('should handle unknown DioException', () {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(),
          error: 'Unknown Error',
        );

        final exception = AppHttpClientException.fromDioException(dioException);

        // Act and Assert
        expect(exception.errorType, ErrorType.unknown);
        expect(exception.statusCode, 500);
        expect(exception.statusMessage, '');
      });
    });
  });
}
