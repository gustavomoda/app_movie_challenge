import 'dart:async';
import 'package:app_movie_challenge/generated/l10n.dart';
import 'package:app_movie_challenge/src/config/themes/app_theme.dart';
import 'package:app_movie_challenge/src/features/settings/domains/repositories/settings.dart';
import 'package:app_movie_challenge/src/shared/externals/app_logger.dart';
import 'package:app_movie_challenge/src/shared/externals/http_client/client.dart';
import 'package:app_movie_challenge/src/shared/externals/http_client/options.dart';
import 'package:app_movie_challenge/src/shared/externals/storage/app_storage.dart';
import 'package:app_movie_challenge/src/shared/i10n/app_locale.dart';
import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'fixtures/app_mocks.dart';
import 'fixtures/extenal_mock.dart';

final appTestInjector = GetIt.instance;

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await S.load(const Locale('en', 'US'));
  await S.load(const Locale('pt', 'pt_BR'));

  final clientOptions = ClientOptions(
    baseUrl: 'https://foo.api',
    connectTimeout: const Duration(seconds: 5),
    sendTimeout: const Duration(seconds: 8),
    receiveTimeout: const Duration(seconds: 15),
  );
  final dio = Dio(
    BaseOptions(
      baseUrl: clientOptions.baseUrl,
      connectTimeout: clientOptions.connectTimeout,
      sendTimeout: clientOptions.sendTimeout,
      receiveTimeout: clientOptions.receiveTimeout,
    ),
  );
  final dioAdapterMock = DioAdapter(dio: dio);

  final mockAppLogger = MockAppLogger();
  final mockAppSettingsRepository = MockAppSettingsRepository();
  final mockFlutterStorage = MockFlutterSecureStorage();
  final appLocale = AppLocale(mockAppLogger, mockAppSettingsRepository);

  GetIt.instance
    ..registerSingleton<AppSettingsRepository>(mockAppSettingsRepository)
    ..registerSingleton<FlutterSecureStorage>(mockFlutterStorage)
    ..registerSingleton<Dio>(dio, instanceName: 'dioTest', signalsReady: true)
    ..registerSingleton<DioAdapter>(dioAdapterMock, signalsReady: true)
    ..registerSingleton<AppLogger>(mockAppLogger)
    ..registerSingleton<AppLocale>(appLocale)
    ..registerSingleton<Faker>(Faker())
    ..registerSingleton<AppStorage>(
      AppStorageImpl(
        flutterSecureStorage: mockFlutterStorage,
        logger: mockAppLogger,
      ),
    )
    ..registerSingleton<AppHttpClient>(
      AppHttpClientImpl(options: clientOptions, dio: dio),
      signalsReady: true,
    );
  setUp(() {
    dioAdapterMock.reset();
    reset(mockAppLogger);
    reset(mockAppSettingsRepository);
    reset(mockFlutterStorage);
  });

  return testMain();
}

MaterialApp wrapperMaterialAppForTest(Widget body) {
  final locale = appTestInjector.get<AppLocale>();
  final appTheme = AppTheme(Brightness.light, appTestInjector<AppLogger>());

  return MaterialApp(
    localizationsDelegates: locale.localizationsDelegates,
    supportedLocales: locale.supportedLocales,
    theme: appTheme.theme,
    home: Material(
      child: Builder(
        builder: (context) => MultiProvider(
          providers: [
            Provider(create: (context) => appTestInjector<AppLogger>()),
            ChangeNotifierProvider(create: (_) => appTheme),
          ],
          builder: (context, _) => body,
        ),
      ),
    ),
  );
}
