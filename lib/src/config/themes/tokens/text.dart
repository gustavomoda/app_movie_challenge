import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_theme.dart';

enum AppTextTokens {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelSmall,
  capiton;

  TextStyle toTextStyle(BuildContext context) {
    final textTheme = context.watch<AppTheme>().theme.textTheme;
    TextStyle? textStyle;
    switch (this) {
      case displayLarge:
        textStyle = textTheme.displayLarge;
      case displayMedium:
        textStyle = textTheme.displayMedium;
      case displaySmall:
        textStyle = textTheme.displaySmall;
      case headlineMedium:
        textStyle = textTheme.headlineMedium;
      case headlineSmall:
        textStyle = textTheme.headlineSmall;
      case titleLarge:
        textStyle = textTheme.titleLarge;
      case titleMedium:
        textStyle = textTheme.titleMedium;
      case titleSmall:
        textStyle = textTheme.titleSmall;
      case bodyLarge:
        textStyle = textTheme.bodyLarge;
      case bodyMedium:
        textStyle = textTheme.bodyMedium;
      case bodySmall:
        textStyle = textTheme.bodySmall;
      case labelLarge:
        textStyle = textTheme.labelLarge;
      case labelSmall:
        textStyle = textTheme.labelSmall;
      case capiton:
        textStyle = textTheme.labelSmall!.copyWith(fontSize: 8);
    }
    return textStyle ?? const TextStyle();
  }
}
