// This file is "main.dart"
// ignore_for_file: unused_element

// ignore: implementation_imports
import 'package:dio/src/dio_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../generated/l10n.dart';
part 'user_friendly_error.freezed.dart';

@freezed
class UserFriendlyError with _$UserFriendlyError implements Exception {
  const UserFriendlyError._();

  const factory UserFriendlyError.info({
    required String title,
    required String message,
  }) = _Info;

  const factory UserFriendlyError.warning({
    required String title,
    required String message,
    required Object? cause,
    required StackTrace? stackTrace,
  }) = _Warning;

  const factory UserFriendlyError.fatal({
    required String title,
    required String message,
    required Object? cause,
    required StackTrace? stackTrace,
  }) = _Fatal;

  const factory UserFriendlyError.error({
    required String title,
    required String message,
    required Object? cause,
    required StackTrace? stackTrace,
  }) = _Error;

  factory UserFriendlyError.fatalRequestApi({
    String? message,
    required Object? cause,
    required StackTrace? stackTrace,
  }) =>
      _Fatal(
        message: message ?? S.current.fatalErrorRequestApi,
        title: S.current.errorTitle,
        cause: cause,
        stackTrace: stackTrace,
      );

  factory UserFriendlyError.defaultFatalError({
    required Object? cause,
    required StackTrace? stackTrace,
  }) =>
      _Fatal(
        message: S.current.fatalError,
        title: S.current.errorTitle,
        cause: cause,
        stackTrace: stackTrace,
      );

  factory UserFriendlyError.fromAppHttpClientException(DioException e) => _Error(
        message: S.current.fatalErrorRequestApi,
        title: S.current.errorTitle,
        cause: e,
        stackTrace: null,
      );
}
