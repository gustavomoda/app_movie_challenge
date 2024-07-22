import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    final textStyle = style.toTextStyle(context);

    return Text(
      text,
      style: textStyle.copyWith(color: color, fontWeight: fontWeight),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}
