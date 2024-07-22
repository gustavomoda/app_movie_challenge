import 'package:equatable/equatable.dart';

import '../../../../../shared/exceptions/user_friendly_error.dart';
import '../../../../../shared/presenter/base/base_widget.dart';
import '../../../../movies/domains/entities/movie.dart';

class TopStudiosWithWinnersState extends Equatable {
  const TopStudiosWithWinnersState({
    this.behavior = AppBehavior.loading,
    this.values = const [],
  });

  final AppBehavior behavior;
  final List<StudiosWithWinCount> values;

  TopStudiosWithWinnersState copyWith({
    AppBehavior? behavior,
    List<StudiosWithWinCount>? values,
  }) =>
      TopStudiosWithWinnersState(
        behavior: behavior ?? this.behavior,
        values: values ?? this.values,
      );

  @override
  List<Object?> get props => [behavior];
}

class InertTopStudiosWithWinnersState extends TopStudiosWithWinnersState {
  const InertTopStudiosWithWinnersState({super.behavior});
}

class FailedTopStudiosWithWinnersState extends TopStudiosWithWinnersState {
  const FailedTopStudiosWithWinnersState({required this.error})
      : super(behavior: AppBehavior.failed);

  final UserFriendlyError error;

  @override
  List<Object?> get props => [error, behavior];
}
