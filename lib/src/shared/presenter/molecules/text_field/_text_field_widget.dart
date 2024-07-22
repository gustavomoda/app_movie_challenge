import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/themes/app_theme.dart';
import '../../atoms/texts/texts.dart';
import '../../base/base_widget.dart';
import '../../base/styles/styles.dart';
import '_text_field_styles.dart';
import 'value_textfield.dart';

class TextFieldWidget extends BaseAtomicWidget {
  const TextFieldWidget({
    required this.styles,
    this.label = '',
    this.hintText = '',
    this.helperText = '',
    this.helperStyle,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.controller,
    this.readOnly = false,
    this.autofillHints = const [],
    this.validator,
    this.canObscureText = false,
    this.onTap,
    this.onTapOutside,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.padding,
    this.errorText,
    this.inputFormatters,
    this.suffixIcon,
    super.error,
    super.behaviors = AppBehavior.all,
    super.behavior = AppBehavior.normal,
    super.key,
  });

  final StylesBuilder<TextFieldStyles> styles;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final List<String> autofillHints;
  final FutureOr<String?> Function(String?)? validator;
  final bool canObscureText;

  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final String label;
  final String hintText;
  final String helperText;
  final TextStyle? helperStyle;
  final EdgeInsets? padding;
  final Widget? suffixIcon;

  final bool readOnly;
  final String? errorText;

  @override
  Widget onNormal(BuildContext context) {
    final style = styles(context).resolve(behavior);
    final valuesNotifier = ValueNotifier(
      ValueTextField(text: canObscureText, errorMessage: errorText),
    );

    final resolveTextStyle = WidgetStateTextStyle.resolveWith((states) {
      if (states.contains(WidgetState.error)) {
        return style.errorStyle;
      }
      if (states.contains(WidgetState.disabled)) {
        return const TextStyle();
      }
      return style.successStyle;
    });
    final resolveFillColor = WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.error)) {
        return style.errorFillColor;
      }
      if (states.contains(WidgetState.disabled)) {
        return style.fillColor;
      }
      return style.successFillColor;
    });
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: AppTheme.spacings.md),
      child: ValueListenableBuilder(
        valueListenable: valuesNotifier,
        builder: (context, values, _) => TextFormField(
          readOnly: readOnly,
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          autofillHints: autofillHints,
          obscureText: values.text,
          inputFormatters: inputFormatters,
          enableInteractiveSelection: true,
          onChanged: (value) async {
            if (validator != null) {
              final errorMessage = await validator!(value);
              valuesNotifier.value = valuesNotifier.value = ValueTextField(
                text: values.text,
                errorMessage: errorMessage,
              );
            }
          },
          onTap: onTap,
          onTapOutside: onTapOutside,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppTheme.spacings.xs,
            ),
            label: label.isNotEmpty ? AppTexts.labelSmall(label) : null,
            hintText: hintText,
            helperText: helperText.isNotEmpty ? helperText : null,
            helperStyle: helperStyle ?? style.helperStyle,
            helperMaxLines: 3,
            errorMaxLines: 3,
            border: style.border,
            enabledBorder: style.enabledBorder,
            errorBorder: style.errorBorder,
            disabledBorder: style.disabledBorder,
            focusedBorder: style.focusedBorder,
            focusedErrorBorder: style.focusedErrorBorder,
            errorStyle: style.errorStyle,
            enabled: !readOnly,
            fillColor: resolveFillColor,
            focusColor: style.fillColor,
            hoverColor: style.fillColor,
            floatingLabelStyle: resolveTextStyle,
            hintStyle: resolveTextStyle,
            labelStyle: resolveTextStyle,
            filled: true,
            errorText: values.errorMessage,
            suffixIcon: suffixIcon == null && canObscureText
                ? IconButton(
                    icon: Icon(
                      values.text ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
                      color: style.fillColor,
                    ),
                    onPressed: () {
                      valuesNotifier.value = valuesNotifier.value.copyWith(text: !values.text);
                    },
                  )
                : suffixIcon,
          ),
        ),
      ),
    );
  }
}
