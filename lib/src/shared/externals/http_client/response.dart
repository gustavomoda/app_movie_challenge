import 'dart:convert';

import 'package:dio/dio.dart' as extenal_dio;

import '../../exceptions/user_friendly_error.dart';

class Response<T> {
  Response({
    required this.data,
    this.originalData,
    this.statusCode = 500,
    this.statusMessage = '',
  });

  factory Response.fromDioResponse(
    extenal_dio.Response<String> response, {
    T Function(Map<String, dynamic>)? fromJson,
    bool asList = false,
  }) {
    try {
      T? data;
      if (fromJson != null) {
        final dynamic decoded = jsonDecode(response.data!);
        if (asList) {
          data = (decoded as List).map((e) => fromJson(e as Map<String, dynamic>)).toList() as T;
        } else {
          data = fromJson(decoded as Map<String, dynamic>);
        }
      } else {
        data = response.data as T;
      }
      return Response(
        data: data,
        originalData: response.data,
        statusCode: response.statusCode!,
        statusMessage: response.statusMessage!,
      );
    } catch (e, s) {
      throw UserFriendlyError.fatalRequestApi(cause: e, stackTrace: s);
    }
  }

  static Response<List<T>> fromDioResponseAsList<T>(
    extenal_dio.Response<String> response, {
    T Function(Map<String, dynamic>)? fromJson,
  }) {
    try {
      var data = <T>[];
      if (response.data != null) {
        final dynamic decoded = jsonDecode(response.data!);
        if (fromJson != null) {
          data = List.from(decoded).map((e) => fromJson(e as Map<String, dynamic>)).toList();
        } else {
          data = List.from(decoded).map((e) => e as T).toList();
        }
      }
      return Response<List<T>>(
        data: data,
        originalData: response.data,
        statusCode: response.statusCode!,
        statusMessage: response.statusMessage!,
      );
    } catch (e, s) {
      throw UserFriendlyError.fatalRequestApi(cause: e, stackTrace: s);
    }
  }

  final T? data;
  final String? originalData;
  final int statusCode;
  final String statusMessage;

  bool get isOk => statusCode >= 200 && statusCode < 300;
}
