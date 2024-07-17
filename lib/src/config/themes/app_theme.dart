import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../di/app_injector.dart';
import '../../features/settings/domains/repositories/settings.dart';
import 'tokens/colors.dart';
import 'tokens/spacing.dart';

class AppTheme with ChangeNotifier {
  AppTheme(this.brightnessValue, this._logger) {
    theme = ThemeData.light();
    _instance = this;
  }

  static late AppTheme? _instance;

  final Logger _logger;

  Brightness brightnessValue;

  // Shortcut to get the current theme
  static AppTheme get current => _instance!;

  // Shortcut to get the current theme data
  TextTheme get textTheme => theme.textTheme;

  static AppSpacingsTokens spacings = AppSpacingsTokens();

  ThemeData theme = ThemeData();

  AppColorsTokens colorTokens = AppColorsLightTokens();

  bool isInitedFromPlatform = false;

  bool get isDarkMode => brightnessValue == Brightness.dark;

  Future<void> change(Brightness brightnessValue, BuildContext context) async {
    _logger.d('[AppTheme] Changing theme to $brightnessValue');
    this.brightnessValue = brightnessValue;
    theme = _createThemeData(context);

    notifyListeners();

    try {
      await appInjector.get<AppSettingsRepository>().saveThemeMode(brightnessValue);
    } catch (e) {
      _logger.w('[AppTheme] Error saving theme mode: $e');
    }
  }

  ThemeData _createThemeData(BuildContext context) {
    _logger.d('[AppTheme] Creating theme data for $brightnessValue');

    colorTokens =
        brightnessValue == Brightness.dark ? AppColorsDarkTokens() : AppColorsLightTokens();

    final data = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: colorTokens.backgroundColor.computeLuminance() > 0.5
            ? Brightness.light
            : Brightness.dark,
        primary: colorTokens.primaryColor,
        onPrimary: colorTokens.onPrimaryColor,
        secondary: colorTokens.secondaryColor,
        onSecondary: colorTokens.onSecondaryColor,
        error: colorTokens.errorColor,
        onError: colorTokens.onErrorColor,
        surface: colorTokens.backgroundColor,
        onSurface: colorTokens.onBackgroundColor,
      ),
    );

    final textTheme = data.textTheme;
    return data.copyWith(
      inputDecorationTheme: data.inputDecorationTheme.copyWith(
        border: const OutlineInputBorder(),
      ),
      textTheme: textTheme.copyWith(
        displayLarge: textTheme.displayLarge?.copyWith(fontSize: 32),
        displayMedium: textTheme.displayMedium?.copyWith(fontSize: 30),
        displaySmall: textTheme.displaySmall?.copyWith(fontSize: 28),
        headlineMedium: textTheme.headlineMedium?.copyWith(fontSize: 26),
        headlineSmall: textTheme.headlineSmall?.copyWith(fontSize: 24),
        titleLarge: textTheme.titleLarge?.copyWith(fontSize: 22),
        titleMedium: textTheme.titleMedium?.copyWith(fontSize: 16),
        titleSmall: textTheme.titleSmall?.copyWith(fontSize: 14),
        bodyLarge: textTheme.bodyLarge?.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
        bodyMedium: textTheme.bodyMedium?.copyWith(fontSize: 14),
        bodySmall: textTheme.bodySmall?.copyWith(fontSize: 12),
        labelLarge: textTheme.labelLarge?.copyWith(fontSize: 14),
        labelSmall: textTheme.labelSmall?.copyWith(fontSize: 11),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        enableFeedback: false,
        selectedItemColor: colorTokens.primaryColor,
        unselectedItemColor: colorTokens.secondaryColor,
        selectedIconTheme: IconThemeData(color: colorTokens.primaryColor),
        unselectedIconTheme: IconThemeData(color: colorTokens.secondaryColor),
        selectedLabelStyle: TextStyle(color: colorTokens.primaryColor),
        unselectedLabelStyle: TextStyle(color: colorTokens.secondaryColor),
      ),
    );
  }

  Future<void> initFromPlatformIfNotYet(BuildContext context) async {
    if (isInitedFromPlatform) {
      return;
    }
    _logger.d('[AppTheme] Init theme from platform if not yet');
    try {
      await appInjector
          .get<AppSettingsRepository>()
          .getThemeMode()
          .then((value) => change(value, context));
    } catch (e) {
      _logger.d('[AppTheme] Error getting theme mode: $e');
      // ignore: use_build_context_synchronously
      await change(MediaQuery.platformBrightnessOf(context), context);
    }
  }

  ThemeData didChangePlatformBrightness(BuildContext context) {
    _logger.d('[AppTheme] Did change platform brightness');
    final newBrightnessValue = MediaQuery.platformBrightnessOf(context);
    if (brightnessValue != newBrightnessValue) {
      _logger.d('[AppTheme] Theme is already $brightnessValue');
    } else {
      unawaited(change(newBrightnessValue, context));
    }
    return theme;
  }

  void toogleTheme(BuildContext context) {
    unawaited(change(isDarkMode ? Brightness.light : Brightness.dark, context));
  }
}
