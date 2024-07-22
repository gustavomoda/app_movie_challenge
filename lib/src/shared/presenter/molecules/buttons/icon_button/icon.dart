import 'package:flutter/material.dart';

import '../../../base/base_widget.dart';
import '_styles.dart';
import '_widget.dart';

class AppIconButtons extends AppIconButtonWidget {
  const AppIconButtons._({
    required super.icon,
    required super.onTap,
    required super.styles,
    super.behavior,
    List<AppBehavior>? behaviors,
  }) : super(behaviors: behaviors ?? AppBehavior.all);

  factory AppIconButtons.primary({
    required IconData icon,
    required VoidCallback? onTap,
    List<AppBehavior>? behaviors,
    AppBehavior behavior = AppBehavior.normal,
  }) =>
      AppIconButtons._(
        icon: icon,
        onTap: onTap,
        styles: appIconButtonSpecs.primary,
        behavior: behavior,
        behaviors: behaviors,
      );
}
