import 'dart:async';
import 'package:app_movie_challenge/generated/l10n.dart';
import 'package:app_movie_challenge/src/shared/externals/app_logger.dart';
import 'package:app_movie_challenge/src/shared/externals/storage/app_storage.dart';
import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';

import 'fixtures/extenal_mock.dart';

final appTestInjector = GetIt.instance;

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  WidgetsFlutterBinding.ensureInitialized();

  await S.load(const Locale('en', 'US'));
  await S.load(const Locale('pt', 'pt_BR'));
  final dio = Dio(
    BaseOptions(
      // baseUrl: AppConfig.instance.urlApi,
      connectTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 8),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );
  final dioAdapterMock = DioAdapter(dio: dio);

  final appLogger = AppLogger(level: Level.debug);
  final flutterStorageMock = MockFlutterSecureStorage();

  GetIt.instance
    ..registerSingleton<FlutterSecureStorage>(flutterStorageMock)
    ..registerSingleton<Dio>(dio, instanceName: 'dioTest', signalsReady: true)
    ..registerSingleton<DioAdapter>(dioAdapterMock, signalsReady: true)
    ..registerSingleton<AppLogger>(appLogger)
    ..registerSingleton<Faker>(Faker())
    ..registerSingleton<AppStorage>(
      AppStorageImpl(
        flutterSecureStorage: flutterStorageMock,
        logger: appLogger,
      ),
    );
  // ..registerSingleton<AppHttpClient>(
  //   AppHttpClientImpl({dio: dio}),
  //   instanceName: 'clientRestApiTest',
  //   signalsReady: true,
  // );
  setUp(() {
    dioAdapterMock.reset();
    reset(flutterStorageMock);
  });

  return testMain();
}
