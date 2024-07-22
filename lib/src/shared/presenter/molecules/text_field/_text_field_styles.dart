import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/themes/app_theme.dart';
import '../../base/styles/styles.dart';

final ({StylesBuilder<TextFieldStyles> standard}) textFieldSpecs = (
  standard: (context) {
    final theme = context.read<AppTheme>();
    final defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: theme.colorTokens.onPrimaryColor,
        width: 0.5,
      ),
    );
    return Styles<TextFieldStyles>(
      normal: TextFieldStyles(
        border: defaultBorder,
        enabledBorder: defaultBorder,
        disabledBorder: defaultBorder,
        focusedBorder: defaultBorder,
        focusedErrorBorder: defaultBorder,
        errorBorder: defaultBorder,
        errorFillColor: theme.colorTokens.errorColor.withOpacity(0.8),
        fillColor: Colors.transparent,
        successFillColor: Colors.transparent,
        errorStyle: TextStyle(color: theme.colorTokens.onPrimaryColor),
        helperStyle: TextStyle(color: theme.colorTokens.onPrimaryColor),
        successStyle: TextStyle(color: theme.colorTokens.onPrimaryColor),
      ),
    );
  }
);

class TextFieldStyles {
  const TextFieldStyles({
    required this.border,
    required this.enabledBorder,
    required this.errorBorder,
    required this.disabledBorder,
    required this.focusedBorder,
    required this.focusedErrorBorder,
    required this.fillColor,
    required this.errorFillColor,
    required this.successFillColor,
    required this.errorStyle,
    required this.successStyle,
    required this.helperStyle,
  });

  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final TextStyle errorStyle;
  final TextStyle successStyle;
  final TextStyle helperStyle;

  final Color fillColor;
  final Color errorFillColor;
  final Color successFillColor;
}
