import 'package:app_movie_challenge/src/shared/exceptions/user_friendly_error.dart';
import 'package:app_movie_challenge/src/shared/externals/http_client/response.dart';
import 'package:dio/dio.dart' as external_dio;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppHttpClient:', () {
    group('Response Wrapper:', () {
      test('should correctly wrap a successful Dio response', () {
        // Create a mock Dio response
        final dioResponse = external_dio.Response<String>(
          data: 'Success data',
          statusCode: 200,
          statusMessage: 'OK',
          requestOptions: external_dio.RequestOptions(path: 'http://example.com'),
        );

        // Wrap the Dio response
        final response = Response.fromDioResponse(dioResponse);

        // Test that the Response object has the correct data and flags
        expect(response.data, equals('Success data'));
        expect(response.statusCode, equals(200));
        expect(response.statusMessage, equals('OK'));
        expect(response.isOk, isTrue);
      });

      test('should correctly identify non-successful HTTP status codes', () {
        // Create a mock Dio response for an error
        final dioResponse = external_dio.Response<String>(
          data: 'Error occurred',
          statusCode: 404,
          statusMessage: 'Not Found',
          requestOptions: external_dio.RequestOptions(path: 'http://example.com'),
        );

        // Wrap the Dio response
        final response = Response.fromDioResponse(dioResponse);

        // Test that the Response object correctly identifies non-successful responses
        expect(response.data, equals('Error occurred'));
        expect(response.statusCode, equals(404));
        expect(response.statusMessage, equals('Not Found'));
        expect(response.isOk, isFalse);
      });

      test('should correctly handle a null Dio response', () {
        // Create a mock Dio response with null data
        final dioResponse = external_dio.Response<String>(
          data: null,
          statusCode: 200,
          statusMessage: 'OK',
          requestOptions: external_dio.RequestOptions(path: 'http://example.com'),
        );

        // Wrap the Dio response
        final response = Response.fromDioResponse(dioResponse);

        // Test that the Response object correctly handles null data
        expect(response.data, isNull);
        expect(response.statusCode, equals(200));
        expect(response.statusMessage, equals('OK'));
        expect(response.isOk, isTrue);
      });

      test('should correctly handle JSON decoding errors', () {
        // Create a mock Dio response with invalid JSON
        final dioResponse = external_dio.Response<String>(
          data: 'Invalid JSON',
          statusCode: 200,
          statusMessage: 'OK',
          requestOptions: external_dio.RequestOptions(path: 'http://example.com'),
        );

        expect(
          () => Response.fromDioResponse(
            dioResponse,
            fromJson: (json) => json, // Mock fromJson function
          ),
          throwsA(isA<UserFriendlyError>()),
        );
      });

      test('should correctly wrap a Dio response as a list', () {
        // Create a mock Dio response with a list of JSON objects
        final dioResponse = external_dio.Response<String>(
          data: '[{"id": 1, "name": "Item 1"}, {"id": 2, "name": "Item 2"}]',
          statusCode: 200,
          statusMessage: 'OK',
          requestOptions: external_dio.RequestOptions(path: 'http://example.com'),
        );

        // Wrap the Dio response as a list
        final response = Response.fromDioResponseAsList<Map<String, dynamic>>(
          dioResponse,
          fromJson: (json) => json,
        );

        // Test that the Response object has the correct data and flags
        expect(response.data, isA<List<Map<String, dynamic>>>());
        expect(response.data?.length, equals(2));
        expect(response.data?[0]['id'], equals(1));
        expect(response.data?[0]['name'], equals('Item 1'));
        expect(response.statusCode, equals(200));
        expect(response.statusMessage, equals('OK'));
        expect(response.isOk, isTrue);
      });
    });
  });
}
