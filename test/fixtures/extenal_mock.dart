import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

class MockRequestInterceptorHandler extends Mock implements RequestInterceptorHandler {}

class MockResponseInterceptorHandler extends Mock implements ResponseInterceptorHandler {}

class MockErrorInterceptorHandler extends Mock implements ErrorInterceptorHandler {}

class MockDio extends Mock implements Dio {}

class MockBuildContext extends Mock implements BuildContext {}
