import 'package:flutter/material.dart';

import '../../../config/themes/app_theme.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: 120,
        height: 120,
        padding: EdgeInsets.all(AppTheme.spacings.xs),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(AppTheme.spacings.md),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.spacings.md),
          child: Image.asset(
            'assets/brand/logo.png',
          ),
        ),
      );
}
