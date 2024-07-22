import 'package:flutter/material.dart';

import '../../../../config/themes/app_theme.dart';
import '../../base/styles/styles.dart';

final ({StylesBuilder<TableStyles> primary}) appTableSpecs = (
  primary: (context) => Styles<TableStyles>(
        normal: TableStyles(
          borderWidth: 0.5,
          borderColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3),
          padding: EdgeInsets.all(AppTheme.spacings.xs),
        ),
      )
);

class TableStyles {
  const TableStyles({
    required this.borderWidth,
    required this.borderColor,
    required this.padding,
  });

  final double borderWidth;
  final Color borderColor;
  final EdgeInsets padding;
}
