import 'package:equatable/equatable.dart';

import '../../../../../shared/exceptions/user_friendly_error.dart';
import '../../../../../shared/presenter/base/base_widget.dart';
import '../../../../movies/domains/entities/movie.dart';

class YearWithMulpleWinnerState extends Equatable {
  const YearWithMulpleWinnerState({
    this.behavior = AppBehavior.loading,
    this.values = const [],
  });

  final AppBehavior behavior;
  final List<WinnerByYear> values;

  YearWithMulpleWinnerState copyWith({
    AppBehavior? behavior,
    List<WinnerByYear>? values,
  }) =>
      YearWithMulpleWinnerState(
        behavior: behavior ?? this.behavior,
        values: values ?? this.values,
      );

  @override
  List<Object?> get props => [behavior];
}

class InertYearWithMulpleWinnerState extends YearWithMulpleWinnerState {
  const InertYearWithMulpleWinnerState({super.behavior});
}

class FailedYearWithMulpleWinnerState extends YearWithMulpleWinnerState {
  const FailedYearWithMulpleWinnerState({required this.error})
      : super(behavior: AppBehavior.failed);

  final UserFriendlyError error;

  @override
  List<Object?> get props => [error, behavior];
}
