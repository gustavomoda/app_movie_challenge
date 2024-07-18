import 'package:app_movie_challenge/src/config/themes/app_theme.dart';
import 'package:app_movie_challenge/src/features/settings/domains/repositories/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/app_mocks.dart';
import '../../../fixtures/extenal_mock.dart';
import '../../../flutter_test_config.dart';

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
      // Act
      final appTheme = AppTheme(Brightness.light, mockAppLogger);

      // Assert
      expect(appTheme.brightnessValue, Brightness.light);
      expect(appTheme.theme.brightness, Brightness.light);
    });

    test('should change theme to dark', () async {
      // Arrange
      final appTheme = AppTheme(Brightness.light, mockAppLogger);

      when(() => mockAppSettingsRepository.saveThemeMode(any())).thenAnswer((_) async => {});

      // Act
      await appTheme.change(Brightness.dark, MockBuildContext());

      // Assert
      verify(
        () => mockAppLogger.d('[AppTheme] Changing theme to Brightness.dark'),
      ).called(1);
      expect(appTheme.brightnessValue, Brightness.dark);
      expect(appTheme.theme.brightness, Brightness.dark);
    });

    test('should create correct theme data', () async {
      // Arrange
      final appTheme = AppTheme(Brightness.light, mockAppLogger);

      // Act
      await appTheme.change(Brightness.light, mockContext);
      final themeData = appTheme.theme;

      // Assert
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
      // Arrange
      final appTheme = AppTheme(Brightness.light, mockAppLogger);

      when(() => mockAppSettingsRepository.saveThemeMode(any())).thenAnswer((_) async => {});

      var isNotified = false;
      appTheme.addListener(() {
        isNotified = true;
      });

      // Act
      await appTheme.change(Brightness.dark, MockBuildContext());

      // Assert
      expect(isNotified, isTrue);
    });

    test('should initialize theme from platform if not yet initialized', () async {
      // Arrange
      final appTheme = AppTheme(Brightness.light, mockAppLogger);

      when(mockAppSettingsRepository.getThemeMode).thenAnswer((_) async => Brightness.dark);

      // Act
      await appTheme.initFromPlatformIfNotYet(mockContext);

      // Assert
      verify(mockAppSettingsRepository.getThemeMode).called(1);
    });

    test('should do nothing when the theme from the platform is already initialized', () async {
      // Arrange
      final appTheme = AppTheme(Brightness.light, mockAppLogger)..isInitedFromPlatform = true;

      // Act
      await appTheme.initFromPlatformIfNotYet(mockContext);

      // Assert
      verifyNever(mockAppSettingsRepository.getThemeMode);
    });
  });
}
