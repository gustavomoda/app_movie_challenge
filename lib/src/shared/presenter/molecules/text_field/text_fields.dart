import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '_text_field_styles.dart';
import '_text_field_widget.dart';

export 'formatters.dart';

class AppTextFields extends TextFieldWidget {
  AppTextFields.standard({
    super.readOnly,
    super.validator,
    super.onEditingComplete,
    super.onFieldSubmitted,
    super.onTap,
    super.key,
    super.controller,
    super.label,
    super.hintText,
    super.padding,
    super.autofillHints,
    super.keyboardType,
    super.inputFormatters,
    super.errorText,
    super.helperText,
    super.helperStyle,
  }) : super(styles: textFieldSpecs.standard);

  AppTextFields.number({
    super.readOnly,
    super.validator,
    super.onEditingComplete,
    super.onFieldSubmitted,
    super.onTap,
    super.key,
    super.controller,
    super.label,
    super.padding,
    super.errorText,
    super.helperText,
    super.helperStyle,
  }) : super(
          styles: textFieldSpecs.standard,
          keyboardType: TextInputType.number,
          autofillHints: const [],
        );

  AppTextFields.year({
    super.readOnly,
    super.onEditingComplete,
    super.onFieldSubmitted,
    super.onTap,
    super.key,
    super.controller,
    super.label,
    String? hintText,
    ValueChanged<String>? onValid,
    super.padding,
    super.errorText,
    super.helperText,
    super.helperStyle,
    super.suffixIcon,
  }) : super(
          styles: textFieldSpecs.standard,
          hintText: hintText ?? S.current.yearLabel,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.current.requiredFieldErrorMessage;
            }
            final year = int.tryParse(value);
            if (value.length != 4 || year == null) {
              return S.current.invalidYearErrorMessage;
            }
            if (year < 1900 || year > DateTime.now().year) {
              return S.current.invalidYearErrorMessage;
            }
            if (onValid != null) {
              onValid(value);
            }
            return null;
          },
        );
}
