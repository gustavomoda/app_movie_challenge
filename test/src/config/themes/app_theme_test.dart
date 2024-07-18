import 'package:app_movie_challenge/src/config/themes/app_theme.dart';
import 'package:app_movie_challenge/src/features/settings/domains/repositories/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../flutter_test_config.dart';
import '../../shared/externals/http_client/http_interceptors_test.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group('AppTheme Tests', () {
    final mockAppLogger = MockAppLogger();
    final mockContext = MockBuildContext();
    final mockAppSettingsRepository = appTestInjector.get<AppSettingsRepository>();

    setUpAll(() {
      registerFallbackValue(Brightness.light);
    });

    setUp(() {
      reset(mockAppLogger);
      reset(mockAppSettingsRepository);
      reset(mockContext);
    });

    test('should create light theme by default', () {
      final appTheme = AppTheme(Brightness.light, mockAppLogger);
      expect(appTheme.brightnessValue, Brightness.light);
      expect(appTheme.theme.brightness, Brightness.light);
    });

    test('should change theme to dark', () async {
      final appTheme = AppTheme(Brightness.light, mockAppLogger);
      when(() => mockAppSettingsRepository.saveThemeMode(any())).thenAnswer((_) async => {});

      await appTheme.change(Brightness.dark, MockBuildContext());

      verify(
        () => mockAppLogger.d('[AppTheme] Changing theme to Brightness.dark'),
      ).called(1);
      expect(appTheme.brightnessValue, Brightness.dark);
      expect(appTheme.theme.brightness, Brightness.dark);
    });

    test('should create correct theme data', () async {
      final appTheme = AppTheme(Brightness.light, mockAppLogger);

      await appTheme.change(Brightness.light, mockContext);

      final themeData = appTheme.theme;

      expect(themeData.colorScheme.primary, appTheme.colorTokens.primaryColor);
      expect(
        themeData.colorScheme.secondary,
        appTheme.colorTokens.secondaryColor,
      );
      expect(
        themeData.bottomNavigationBarTheme.selectedItemColor,
        appTheme.colorTokens.primaryColor,
      );
      expect(
        themeData.bottomNavigationBarTheme.unselectedItemColor,
        appTheme.colorTokens.secondaryColor,
      );
    });

    test('should change theme and notify listeners', () async {
      final appTheme = AppTheme(Brightness.light, mockAppLogger);

      when(() => mockAppSettingsRepository.saveThemeMode(any())).thenAnswer((_) async => {});

      var isNotified = false;
      appTheme.addListener(() {
        isNotified = true;
      });

      await appTheme.change(Brightness.dark, MockBuildContext());

      expect(isNotified, isTrue);
    });

    test('should initialize theme from platform if not yet initialized', () async {
      final appTheme = AppTheme(Brightness.light, mockAppLogger);

      when(mockAppSettingsRepository.getThemeMode).thenAnswer((_) async => Brightness.dark);

      await appTheme.initFromPlatformIfNotYet(mockContext);

      verify(mockAppSettingsRepository.getThemeMode).called(1);
    });

    test('should do nothing when the theme from the platform is already initialized', () async {
      final appTheme = AppTheme(Brightness.light, mockAppLogger)..isInitedFromPlatform = true;

      await appTheme.initFromPlatformIfNotYet(mockContext);

      verifyNever(mockAppSettingsRepository.getThemeMode);
    });
  });
}
