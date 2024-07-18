// ignore_for_file: require_trailing_commas

import 'package:app_movie_challenge/src/features/settings/domains/repositories/settings.dart';
import 'package:app_movie_challenge/src/shared/i10n/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../flutter_test_config.dart';

void main() {
  final mockAppSettingsRepository = appTestInjector.get<AppSettingsRepository>();
  final appLocale = appTestInjector.get<AppLocale>();

  setUpAll(() {
    reset(mockAppSettingsRepository);
  });

  group('AppLocale Tests', () {
    test('should restore default locale if no saved language', () async {
      when(mockAppSettingsRepository.getLanguage).thenAnswer((_) async => null);

      await appLocale.restore();

      expect(
        appLocale.current,
        const Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
      );
    });

    test('should restore saved language if available', () async {
      when(mockAppSettingsRepository.getLanguage).thenAnswer((_) async => 'en');

      await appLocale.restore();

      expect(appLocale.current, const Locale('en'));
    });

    test('should change locale and save it', () async {
      const newLocale = Locale('en');
      await appLocale.change(newLocale);

      verify(() => mockAppSettingsRepository.saveLanguage('en')).called(1);
      expect(appLocale.current, newLocale);
    });

    test('should return correct language name', () {
      expect(appLocale.getLanguageName(const Locale('pt', 'BR')), 'Português (Brasil)');
      expect(appLocale.getLanguageName(const Locale('en')), 'English');
      expect(appLocale.getLanguageName(const Locale('es')), 'Unknown: es');
    });

    test('should return correct language tag for l10n', () {
      expect(appLocale.toTagl10n(const Locale('pt', 'BR')), 'pt_BR');
      expect(appLocale.toTagl10n(const Locale('en')), 'en');
    });
  });
}
