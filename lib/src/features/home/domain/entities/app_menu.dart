import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../config/routes/app_route.dart';

mixin AppMenu {
  static final dashboardItem =
      (icon: Icons.home, label: S.current.dashboardLabel, route: AppRoutes.home);

  static final moviesItem =
      (icon: Icons.movie, label: S.current.moviesLabel, route: AppRoutes.home);

  static final settingsItem =
      (icon: Icons.settings, label: S.current.settingsLabel, route: AppRoutes.settings);

  static final openMenuItem = (icon: Icons.menu, label: S.current.menuLabel, route: null);

  static final aboutMenu = (icon: Icons.info, label: S.current.aboutLabel, route: null);

  static final developerShowCaseItemMenu = (
    icon: Icons.developer_mode,
    label: S.current.developThemeShowcase,
    route: AppRoutes.developShowcase,
  );

  static final navigatorItems = <({IconData icon, String label, AppRoutes? route})>[
    dashboardItem,
    moviesItem,
    settingsItem,
    openMenuItem,
  ];

  static final drawerMenuItemItems = <({IconData icon, String label, AppRoutes? route})>[
    settingsItem,
    if (kDebugMode) developerShowCaseItemMenu,
    aboutMenu,
  ];
}
