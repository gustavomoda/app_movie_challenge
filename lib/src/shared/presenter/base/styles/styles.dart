import 'package:flutter/material.dart';

import '../base_widget.dart';

typedef StylesBuilder<T> = Styles<T> Function(BuildContext context);

class Styles<T> {
  const Styles({
    required this.normal,
    T? loading,
    T? failed,
  })  : assert(normal != null, 'normal state cannot be nul'),
        loading = loading ?? normal,
        failed = failed ?? normal;

  final T normal;
  final T loading;
  final T failed;

  T resolve(AppBehavior behavior) {
    switch (behavior) {
      case AppBehavior.normal:
        return normal;
      case AppBehavior.loading:
        return loading;
      case AppBehavior.failed:
        return failed;
    }
  }
}
