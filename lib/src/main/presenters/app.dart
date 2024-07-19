import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

import '../../config/routes/app_route.dart';
import '../../config/themes/app_theme.dart';
import '../../di/app_injector.dart';
import '../../shared/externals/app_logger.dart';
import '../../shared/i10n/app_locale.dart';

// TODO(gustavo): May make test?
class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) => KeyboardDismissOnTap(
        child: MultiProvider(
          providers: [
            Provider(create: (context) => AppRouter()),
            Provider(create: (context) => appInjector<AppLogger>()),
            ChangeNotifierProvider(
              create: (context) {
                final appLocale = appInjector<AppLocale>();
                unawaited(appLocale.restore());
                return appLocale;
              },
            ),
            ChangeNotifierProvider(
              create: (_) => AppTheme(
                Brightness.light,
                appInjector<AppLogger>(),
              ),
            ),
          ],
          child: const _MainApp(),
        ),
      );
}

class _MainApp extends StatefulWidget {
  const _MainApp();

  @override
  State<_MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<_MainApp> with WidgetsBindingObserver, WidgetsBindingObserver {
  final logger = appInjector<AppLogger>();

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<AppLocale>();

    return MaterialApp.router(
      locale: locale.current,
      supportedLocales: locale.supportedLocales,
      localizationsDelegates: locale.localizationsDelegates,
      routerConfig: context.read<AppRouter>().routerConfig,
      theme: context.watch<AppTheme>().theme,
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  void initState() {
    // This is run when the widget is first time initialized
    WidgetsBinding.instance.addObserver(this); // Subscribe to changes

    super.initState();

    unawaited(context.read<AppTheme>().initFromPlatformIfNotYet(context));
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    context.read<AppTheme>().didChangePlatformBrightness(context);
  }
}
