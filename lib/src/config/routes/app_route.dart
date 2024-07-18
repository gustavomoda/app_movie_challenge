import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../di/app_injector.dart';
import '../../features/developer/showcases/presenters/showcase.dart';
import '../../features/home/presenters/screens/home.dart';
import '../../features/settings/presenters/screens/settings.dart';
import '../../shared/externals/app_logger.dart';

enum AppRoutes {
  home('/'),
  settings('/app/settings'),
  about('/app/about'),

  // Only for development
  developShowcase('/develop/showcase');

  const AppRoutes(this.path);

  final String path;
}

class AppRouter {
  AppRouter();

  GoRouter? _routerConfig;

  final AppLogger _logger = appInjector<AppLogger>();

  GoRouter get routerConfig => _routerConfig ??= GoRouter(
        initialLocation: AppRoutes.home.path,
        routes: <RouteBase>[
          GoRoute(
            path: AppRoutes.home.path,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.settings.path,
            builder: (context, state) => const SettingsScreen(),
          ),
          GoRoute(
            path: kDebugMode ? AppRoutes.developShowcase.path : AppRoutes.home.path,
            builder: (context, state) => const ShowcaseScreen(),
          ),
        ],
      );

  Future<T?> push<T>(AppRoutes route, {Object? extra}) {
    _logger.d('AppRouter.push: ${route.path}');
    return routerConfig.push<T>(route.path, extra: extra);
  }

  Future<T?> go<T>(AppRoutes route, {Object? extra}) {
    _logger.d('AppRouter.go: ${route.path}');
    return routerConfig.pushReplacement(
      route.path,
      extra: extra,
    );
  }

  void pop<T>(T? result) => routerConfig.pop<T>(result);

  Route? get current {
    Route? current;
    _routerConfig!.routerDelegate.navigatorKey.currentState!.popUntil((route) {
      if (route.settings.name != null) {
        current = route;
        return true;
      }
      return false;
    });
    return current;
  }
}
