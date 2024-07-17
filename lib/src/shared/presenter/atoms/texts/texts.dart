import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../config/themes/tokens/text.dart';

class AppTexts extends StatelessWidget {
  const AppTexts.custom(
    String text, {
    int? maxLines,
    TextAlign? textAlign,
    Color? color,
    Key? key,
    FontWeight? fontWeight,
    AppTextTokens style = AppTextTokens.bodyMedium,
  }) : this._(
          text,
          color: color,
          maxLines: maxLines,
          textAlign: textAlign,
          key: key,
          style: style,
          fontWeight: fontWeight,
        );

  const AppTexts.displayLarge(
    String text, {
    int? maxLines,
    TextAlign? textAlign,
    Color? color,
    Key? key,
    FontWeight? fontWeight,
  }) : this._(
          text,
          style: AppTextTokens.displayLarge,
          color: color,
          maxLines: maxLines,
          textAlign: textAlign,
          key: key,
          fontWeight: fontWeight,
        );

  const AppTexts.displayMedium(
    String text, {
    int? maxLines,
    TextAlign? textAlign,
    Color? color,
    Key? key,
    FontWeight? fontWeight,
  }) : this._(
          text,
          style: AppTextTokens.displayMedium,
          color: color,
          maxLines: maxLines,
          textAlign: textAlign,
          key: key,
          fontWeight: fontWeight,
        );

  const AppTexts.displaySmall(
    String text, {
    int? maxLines,
    TextAlign? textAlign,
    Color? color,
    Key? key,
    FontWeight? fontWeight,
  }) : this._(
          text,
          style: AppTextTokens.displaySmall,
          color: color,
          maxLines: maxLines,
          textAlign: textAlign,
          key: key,
          fontWeight: fontWeight,
        );

  const AppTexts.headlineMedium(
    String text, {
    int? maxLines,
    TextAlign? textAlign,
    Color? color,
    Key? key,
    FontWeight? fontWeight,
  }) : this._(
          text,
          style: AppTextTokens.headlineMedium,
          color: color,
          maxLines: maxLines,
          textAlign: textAlign,
          key: key,
          fontWeight: fontWeight,
        );

  const AppTexts.headlineSmall(
    String text, {
    int? maxLines,
    TextAlign? textAlign,
    Color? color,
    Key? key,
    FontWeight? fontWeight,
  }) : this._(
          text,
          style: AppTextTokens.headlineSmall,
          color: color,
          maxLines: maxLines,
          textAlign: textAlign,
          key: key,
          fontWeight: fontWeight,
        );

  const AppTexts.titleLarge(
    String text, {
    int? maxLines,
    TextAlign? textAlign,
    Color? color,
    Key? key,
    FontWeight? fontWeight,
  }) : this._(
          text,
          style: AppTextTokens.titleLarge,
          color: color,
          maxLines: maxLines,
          textAlign: textAlign,
          key: key,
          fontWeight: fontWeight,
        );

  const AppTexts.titleMedium(
    String text, {
    int? maxLines,
    TextAlign? textAlign,
    Color? color,
    Key? key,
    FontWeight? fontWeight,
  }) : this._(
          text,
          style: AppTextTokens.titleMedium,
          color: color,
          maxLines: maxLines,
          textAlign: textAlign,
          key: key,
          fontWeight: fontWeight,
        );

  const AppTexts.titleSmall(
    String text, {
    int? maxLines,
    TextAlign? textAlign,
    Color? color,
    Key? key,
    FontWeight? fontWeight,
  }) : this._(
          text,
          style: AppTextTokens.titleSmall,
          color: color,
          maxLines: maxLines,
          textAlign: textAlign,
          key: key,
          fontWeight: fontWeight,
        );

  const AppTexts.bodyLarge(
    String text, {
    int? maxLines,
    TextAlign? textAlign,
    Color? color,
    Key? key,
    FontWeight? fontWeight,
  }) : this._(
          text,
          style: AppTextTokens.bodyLarge,
          color: color,
          maxLines: maxLines,
          textAlign: textAlign,
          key: key,
          fontWeight: fontWeight,
        );

  const AppTexts.bodyMedium(
    String text, {
    int? maxLines,
    TextAlign? textAlign,
    Color? color,
    Key? key,
    FontWeight? fontWeight,
  }) : this._(
          text,
          style: AppTextTokens.bodyMedium,
          color: color,
          maxLines: maxLines,
          textAlign: textAlign,
          key: key,
          fontWeight: fontWeight,
        );

  const AppTexts.bodySmall(
    String text, {
    int? maxLines,
    TextAlign? textAlign,
    Color? color,
    Key? key,
    FontWeight? fontWeight,
  }) : this._(
          text,
          style: AppTextTokens.bodySmall,
          color: color,
          maxLines: maxLines,
          textAlign: textAlign,
          key: key,
          fontWeight: fontWeight,
        );

  const AppTexts.labelLarge(
    String text, {
    int? maxLines,
    TextAlign? textAlign,
    Color? color,
    Key? key,
    FontWeight? fontWeight,
  }) : this._(
          text,
          style: AppTextTokens.labelLarge,
          color: color,
          maxLines: maxLines,
          textAlign: textAlign,
          key: key,
          fontWeight: fontWeight,
        );

  const AppTexts.labelSmall(
    String text, {
    int? maxLines,
    TextAlign? textAlign,
    Color? color,
    Key? key,
    FontWeight? fontWeight,
  }) : this._(
          text,
          style: AppTextTokens.labelSmall,
          color: color,
          maxLines: maxLines,
          textAlign: textAlign,
          key: key,
          fontWeight: fontWeight,
        );

  const AppTexts.capiton(
    String text, {
    int? maxLines,
    TextAlign? textAlign,
    Color? color,
    Key? key,
    FontWeight? fontWeight,
  }) : this._(
          text,
          style: AppTextTokens.labelSmall,
          color: color,
          maxLines: maxLines,
          textAlign: textAlign,
          key: key,
          fontWeight: fontWeight,
        );

  const AppTexts._(
    this.text, {
    required this.style,
    this.maxLines,
    this.textAlign,
    this.color,
    this.fontWeight,
    super.key,
  });

  final Color? color;
  final AppTextTokens style;
  final String text;
  final int? maxLines;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;

  // static const TextStyle _emptyStyle = TextStyle();

  // static TextStyle _AppTextTokens style, {Color? color) =>
  //     (style ?? _emptyStyle).copyWith(color: color);

  @override
  Widget build(BuildContext context) {
    final textTheme = context.watch<AppTheme>().theme.textTheme;
    TextStyle? textStyle;
    switch (style) {
      case AppTextTokens.displayLarge:
        textStyle = textTheme.displayLarge;
      case AppTextTokens.displayMedium:
        textStyle = textTheme.displayMedium;
      case AppTextTokens.displaySmall:
        textStyle = textTheme.displaySmall;
      case AppTextTokens.headlineMedium:
        textStyle = textTheme.headlineMedium;
      case AppTextTokens.headlineSmall:
        textStyle = textTheme.headlineSmall;
      case AppTextTokens.titleLarge:
        textStyle = textTheme.titleLarge;
      case AppTextTokens.titleMedium:
        textStyle = textTheme.titleMedium;
      case AppTextTokens.titleSmall:
        textStyle = textTheme.titleSmall;
      case AppTextTokens.bodyLarge:
        textStyle = textTheme.bodyLarge;
      case AppTextTokens.bodyMedium:
        textStyle = textTheme.bodyMedium;
      case AppTextTokens.bodySmall:
        textStyle = textTheme.bodySmall;
      case AppTextTokens.labelLarge:
        textStyle = textTheme.labelLarge;
      case AppTextTokens.labelSmall:
        textStyle = textTheme.labelSmall;
      case AppTextTokens.capiton:
        textStyle = textTheme.labelSmall!.copyWith(fontSize: 8);
    }
    return Text(
      text,
      style: (textStyle ?? const TextStyle()).copyWith(color: color, fontWeight: fontWeight),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}
