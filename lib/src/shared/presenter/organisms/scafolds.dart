import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../config/themes/app_theme.dart';

class AppScaffolds extends Scaffold {
  const AppScaffolds.raw({
    super.key,
    required super.body,
  }) : super();

  AppScaffolds.full(
    BuildContext context, {
    super.key,
    super.floatingActionButton,
    super.floatingActionButtonLocation,
    super.floatingActionButtonAnimator,
    EdgeInsets? padding,
    super.drawer,
    super.endDrawer,
    super.bottomSheet,
    super.bottomNavigationBar,
    PreferredSizeWidget? bottomAppBar,
    String? title,
    required Widget body,
  }) : super(
          appBar: title != null ? AppBar(title: Text(title), bottom: bottomAppBar) : null,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height,
              ),
              child: padding != null
                  ? Padding(
                      padding: padding,
                      child: body,
                    )
                  : body,
            ),
          ),
        );

  AppScaffolds.fullWithSafeArea(
    BuildContext context, {
    Key? key,
    String? title,
    EdgeInsets? padding,
    required Widget body,
    Widget? drawer,
    Widget? endDrawer,
    Widget? bottomNavigationBar,
    PreferredSizeWidget? bottomAppBar,
  }) : this.full(
          context,
          body: SafeArea(child: body),
          key: key,
          title: title,
          bottomAppBar: bottomAppBar,
          padding: padding ?? EdgeInsets.all(AppTheme.spacings.md),
          drawer: drawer,
          bottomNavigationBar: bottomNavigationBar,
          endDrawer: endDrawer,
        );
}
