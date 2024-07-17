import 'package:flutter/material.dart';

import '../../../config/themes/app_theme.dart';

class AppGaps extends SizedBox {
  const AppGaps._({required double width, required double heigth})
      : super(width: width, height: heigth);

  static AppGaps xxs = AppGaps._(width: AppTheme.spacings.xxs, heigth: AppTheme.spacings.xxs);
  static AppGaps xs = AppGaps._(width: AppTheme.spacings.xs, heigth: AppTheme.spacings.xs);
  static AppGaps sm = AppGaps._(width: AppTheme.spacings.sm, heigth: AppTheme.spacings.sm);
  static AppGaps md = AppGaps._(width: AppTheme.spacings.md, heigth: AppTheme.spacings.md);
  static AppGaps lg = AppGaps._(width: AppTheme.spacings.lg, heigth: AppTheme.spacings.lg);
  static AppGaps xl = AppGaps._(width: AppTheme.spacings.xl, heigth: AppTheme.spacings.xl);
  static AppGaps xxl = AppGaps._(width: AppTheme.spacings.xxl, heigth: AppTheme.spacings.xxl);
}
