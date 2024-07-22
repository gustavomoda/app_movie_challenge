import '../../../exceptions/user_friendly_error.dart';
import '../../base/base_widget.dart';
import '_tables_styles.dart';
import '_tables_widget.dart';

class AppTables extends AppTableWidget {
  const AppTables._({
    required super.styles,
    required super.headers,
    required super.content,
    super.onRefresh,
    super.emptyText,
    super.behavior,
    super.error,
    List<AppBehavior>? behaviors,
  }) : super(behaviors: behaviors ?? AppBehavior.all);

  factory AppTables.primary({
    required List<String> headers,
    required List<List<dynamic>> content,
    UserFriendlyError? error,
    String? emptyText,
    List<AppBehavior>? behaviors,
    AppBehavior behavior = AppBehavior.normal,
    void Function()? onRefresh,
  }) =>
      AppTables._(
        headers: headers,
        content: content,
        error: error,
        styles: appTableSpecs.primary,
        behavior: behavior,
        behaviors: behaviors,
        onRefresh: onRefresh,
        emptyText: emptyText,
      );
}
