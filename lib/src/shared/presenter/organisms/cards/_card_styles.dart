import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/themes/app_theme.dart';
import '../../base/styles/styles.dart';

final ({StylesBuilder<CardStyles> primary}) appCardSpecs = (
  primary: (context) {
    final theme = context.read<AppTheme>();
    return Styles<CardStyles>(
      normal: CardStyles(
        backgroundColor: theme.colorTokens.primaryColor.withOpacity(0.5),
        color: theme.colorTokens.onPrimaryColor,
      ),
    );
  }
);

class CardStyles {
  const CardStyles({
    required this.backgroundColor,
    required this.color,
  });

  final Color backgroundColor;
  final Color color;
}
