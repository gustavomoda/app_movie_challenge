import 'package:flutter/material.dart';

import '../../exceptions/user_friendly_error.dart';

// An interface that must be used in all widgets.
// This interface defines the behavior of the widget on the screen.

enum AppBehavior {
  normal,
  loading,
  failed;

  static const List<AppBehavior> all = [normal, loading, failed];
  static const List<AppBehavior> onlyNornal = [normal];

  bool get isNormal => this == normal;
  bool get isLoading => this == loading;
  bool get isFailed => this == failed;
}

abstract class BaseAtomicWidget<S> extends StatelessWidget {
  const BaseAtomicWidget({
    super.key,
    required this.behaviors,
    required this.behavior,
    this.error,
  });

  final List<AppBehavior> behaviors;

  final AppBehavior behavior;
  final UserFriendlyError? error;

  // final Styles<S> styles;

  Widget onNormal(BuildContext context);

  /// The render of the loading behavior [AppBehavior.loading].
  ///
  /// The component render as loading look model, by default the component will be rendered as regular look model ([onRegular]).
  ///
  /// Implement this method on the instance to show the loading indicators to the user.
  Widget onLoading(BuildContext context) => onNormal(context);

  /// The render of the loading behavior [AppBehavior.failed].
  ///
  /// The component render as error feedback to user, by default the component will be rendered as regular look model ([onRegular]).
  ///
  /// Implement this method on the instance to show the error feedback indicators to the user.
  Widget onFailed(BuildContext context) => onNormal(context);

  @override
  Widget build(BuildContext context) {
    switch (behaviors.contains(behavior) ? behavior : AppBehavior.normal) {
      case AppBehavior.loading:
        return onLoading(context);
      case AppBehavior.failed:
        return onFailed(context);
      case AppBehavior.normal:
        return onNormal(context);
    }
  }
}
