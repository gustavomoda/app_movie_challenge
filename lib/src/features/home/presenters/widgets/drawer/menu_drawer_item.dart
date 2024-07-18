import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../config/themes/app_theme.dart';

class MenuDrawerItem extends StatelessWidget {
  const MenuDrawerItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppTheme.spacings.md,
            horizontal: AppTheme.spacings.sm,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: AppTheme.spacings.lg,
                color: context.watch<AppTheme>().theme.colorScheme.primary,
              ),
              SizedBox(width: AppTheme.spacings.md),
              Flexible(
                child: Text(
                  label,
                  style: context.watch<AppTheme>().textTheme.bodyLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
}
