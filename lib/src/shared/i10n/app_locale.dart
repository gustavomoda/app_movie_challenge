import 'dart:async';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injectable/injectable.dart';

import '../../../generated/l10n.dart';
import '../../di/app_injector.dart';
import '../../features/settings/domains/repositories/settings.dart';
import '../externals/app_logger.dart';

@Singleton()
class AppLocale with ChangeNotifier {
  AppLocale(this.appLogger, this.settingsRepository);

  final _defaultLocale = const Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR');

  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates = const [
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  Locale? _currentAppLocale;

  List<Locale> get supportedLocales => S.delegate.supportedLocales;
  final AppLogger appLogger;
  final AppSettingsRepository settingsRepository;

  Future<void> restore() async {
    try {
      final saved = await settingsRepository.getLanguage();
      _currentAppLocale = supportedLocales.where((e) => e.toLanguageTag() == saved).firstOrNull;
      _currentAppLocale ??= _defaultLocale;
      notifyListeners();
    } catch (e) {
      appLogger.w('[AppLocale] Error restoring language: $e');
      _currentAppLocale = _defaultLocale;
    }
  }

  Future<void> change(Locale locale) async {
    _currentAppLocale = locale;
    notifyListeners();
    try {
      await appInjector
          .get<AppSettingsRepository>()
          .saveLanguage(_currentAppLocale!.toLanguageTag());
    } catch (e) {
      appLogger.w('[AppLocale] Error saving language: $e');
    }
  }

  Locale get current => _currentAppLocale ?? _defaultLocale;

  String currentAstagl10n() => toTagl10n(current);

  String getLanguageName(Locale e) {
    switch (e.toLanguageTag()) {
      case 'pt-BR':
        return 'Português (Brasil)';
      case 'en':
        return 'English';
      default:
        return 'Unknown: ${e.toLanguageTag()}';
    }
  }

  String toTagl10n(Locale e) => e.toLanguageTag().replaceAll('-', '_');
}
