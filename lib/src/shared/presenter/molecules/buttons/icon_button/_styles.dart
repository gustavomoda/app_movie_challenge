import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../config/themes/app_theme.dart';
import '../../../base/styles/styles.dart';

final ({StylesBuilder<AppIconButtonStyles> primary}) appIconButtonSpecs = (
  primary: (context) {
    final theme = context.read<AppTheme>();
    return Styles<AppIconButtonStyles>(
      normal: AppIconButtonStyles(
        color: theme.colorTokens.onPrimaryColor,
      ),
    );
  }
);

class AppIconButtonStyles {
  const AppIconButtonStyles({required this.color});

  final Color color;
}
