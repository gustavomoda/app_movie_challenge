import 'package:flutter/material.dart';

import '../../atoms/texts/texts.dart';

class AppEleveatedButton extends ElevatedButton {
  AppEleveatedButton._({
    super.key,
    required String label,
    super.onPressed,
    super.style,
  }) : super(
          child: AppTexts.labelLarge(label),
        );

  AppEleveatedButton.primary({
    Key? key,
    VoidCallback? onPressed,
    required String label,
  }) : this._(
          key: key,
          label: label,
          onPressed: onPressed,
        );
}
