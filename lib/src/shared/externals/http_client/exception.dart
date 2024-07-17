import 'package:dio/dio.dart';

enum ErrorType {
  connectionTimeout,
  sendTimeout,
  receiveTimeout,
  badCertificate,
  badResponse,
  cancel,
  connectionError,
  unknown,
}

class AppHttpClientException extends Error {
  AppHttpClientException({
    required this.error,
    this.statusCode = 500,
    this.statusMessage = '',
    DioExceptionType? exceptionType,
    required this.stackTrace,
  }) : errorType = _getErrorType(exceptionType);

  factory AppHttpClientException.fromDioException(DioException e) => AppHttpClientException(
        error: e.error,
        statusCode: e.response?.statusCode ?? 500,
        statusMessage: e.response?.statusMessage ?? '',
        exceptionType: e.type,
        stackTrace: e.stackTrace,
      );

  final Object? error;
  final int statusCode;
  final String statusMessage;
  final ErrorType errorType;

  @override
  final StackTrace? stackTrace;

  static ErrorType _getErrorType(DioExceptionType? exceptionType) {
    switch (exceptionType) {
      case DioExceptionType.connectionTimeout:
        return ErrorType.connectionTimeout;
      case DioExceptionType.sendTimeout:
        return ErrorType.sendTimeout;
      case DioExceptionType.receiveTimeout:
        return ErrorType.receiveTimeout;
      case DioExceptionType.badCertificate:
        return ErrorType.badCertificate;
      case DioExceptionType.badResponse:
        return ErrorType.badResponse;
      case DioExceptionType.cancel:
        return ErrorType.cancel;
      case DioExceptionType.connectionError:
        return ErrorType.connectionError;
      case null:
      case DioExceptionType.unknown:
        return ErrorType.unknown;
    }
  }
}
