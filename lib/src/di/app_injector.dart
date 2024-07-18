import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../features/movies/datasources/movie_datasource.dart';
import '../features/movies/datasources/remote/movie_remote_datasource.dart';
import '../shared/externals/app_logger.dart';
import '../shared/externals/http_client/client.dart';
import '../shared/externals/http_client/http_interceptors.dart';
import '../shared/externals/http_client/options.dart';
import 'annotations.dart';
import 'app_injector.config.dart';

final appInjector = GetIt.instance;

@module
abstract class AppModule {
  @prod
  @dev
  @singleton
  AppLogger loggerProd() => AppLogger(level: kDebugMode ? Level.debug : Level.warning);

  @prod
  @dev
  FlutterSecureStorage flutterSecureStorage() => const FlutterSecureStorage();

  @prod
  @dev
  @apiMoviesClient
  AppHttpClient clientApi(
    AppHttpInterceptors interceptors,
  ) =>
      AppHttpClientImpl(
        options: ClientOptions(
          baseUrl: 'https://tools.texoit.com/backend-java/api/movies',
          connectTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 8),
          receiveTimeout: const Duration(seconds: 15),
        ),
      )..addInterceptor(interceptors);

  @prod
  @dev
  @remoteDataSource
  MovieDataSource weatherRemoteDataSource(
    @apiMoviesClient AppHttpClient client,
  ) =>
      MovieRemoteDataSource(client: client);
}

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
  includeMicroPackages: true,
)
Future<void> configureDependencies([
  String environment = Environment.prod,
]) async {
  $initGetIt(appInjector, environment: environment);
  await appInjector.allReady();
}
