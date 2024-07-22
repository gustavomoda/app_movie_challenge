import 'package:flutter/material.dart';

import '../../../base/base_widget.dart';
import '../../../base/styles/styles.dart';
import '_styles.dart';

class AppIconButtonWidget extends BaseAtomicWidget {
  const AppIconButtonWidget({
    required this.styles,
    required this.icon,
    this.onTap,
    super.key,
    super.behaviors = AppBehavior.all,
    super.behavior = AppBehavior.normal,
  });

  final StylesBuilder<AppIconButtonStyles> styles;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget onNormal(BuildContext context) =>
      IconButton(onPressed: behavior.isLoading ? null : onTap, icon: Icon(icon));
}
