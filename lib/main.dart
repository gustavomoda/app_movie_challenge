import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import 'src/di/app_injector.dart' as app_injector;
import 'src/main/presenters/app.dart';
import 'src/shared/externals/app_logger.dart';

Future<void> main({
  Future<void> Function(String environment)? configureDependencies,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  const environment = kDebugMode ? Environment.dev : Environment.prod;
  if (configureDependencies != null) {
    await configureDependencies(environment);
  } else {
    await app_injector.configureDependencies(environment);
  }

  final appLogger = app_injector.appInjector<AppLogger>();

  FlutterError.onError = appLogger.flutterError;

  PlatformDispatcher.instance.onError = appLogger.platformError;

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const App());
  });
}
