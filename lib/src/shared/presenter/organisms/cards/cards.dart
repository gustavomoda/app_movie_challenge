import 'package:flutter/material.dart';

import '../../../exceptions/user_friendly_error.dart';
import '../../base/base_widget.dart';
import '_card_styles.dart';
import '_card_widget.dart';

class AppCards extends AppCardWidget {
  const AppCards._({
    required super.styles,
    required super.title,
    super.subtitle,
    required super.content,
    super.header,
    super.constraints,
    required super.error,
    required super.onRefresh,
    super.behavior,
    List<AppBehavior>? behaviors,
  }) : super(behaviors: behaviors ?? AppBehavior.all);

  factory AppCards.primary({
    required String title,
    String? subtitle,
    required Widget content,
    Widget? header,
    BoxConstraints? constraints,
    UserFriendlyError? error,
    List<AppBehavior>? behaviors,
    AppBehavior behavior = AppBehavior.normal,
    void Function()? onRefresh,
  }) =>
      AppCards._(
        title: title,
        subtitle: subtitle,
        content: content,
        header: header,
        constraints: constraints,
        error: error,
        styles: appCardSpecs.primary,
        behavior: behavior,
        behaviors: behaviors,
        onRefresh: onRefresh,
      );
}
