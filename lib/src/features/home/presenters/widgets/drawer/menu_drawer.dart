import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../config/routes/app_route.dart';
import '../../../../../config/themes/app_theme.dart';
import '../../../../../main/presenters/widgets/app_icon.dart';
import '../../../../about/presenters/dialogs/about.dart';
import '../../../domain/entities/app_menu.dart';
import 'menu_drawer_item.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    const divider = Divider();

    return Container(
      padding: EdgeInsets.only(
        top: AppTheme.spacings.sm + MediaQuery.of(context).padding.top,
        bottom: AppTheme.spacings.sm + MediaQuery.of(context).padding.bottom,
      ),
      child: Drawer(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppTheme.spacings.lg),
            bottomLeft: Radius.circular(AppTheme.spacings.lg),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppTheme.spacings.xl,
            horizontal: AppTheme.spacings.md,
          ),
          child: Column(
            children: [
              const _Header(),
              const Spacer(),
              ...AppMenu.drawerMenuItemItems
                  .map(
                    (e) => MenuDrawerItem(
                      icon: e.icon,
                      label: e.label,
                      onTap: () async {
                        if (e == AppMenu.aboutMenu) {
                          await AppAboutDialog.show(context);
                        } else if (e.route != null) {
                          await context.read<AppRouter>().push(e.route!);
                        }
                      },
                    ),
                  )
                  .map((e) => [e, divider])
                  .expand((e) => e),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: AppTheme.spacings.xl),
        child: Column(
          children: [
            const AppIcon(),
            Center(
              child: Text(
                S.of(context).appName,
              ),
            ),
          ],
        ),
      );
}
