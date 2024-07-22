import 'package:equatable/equatable.dart';

import '../../../../../shared/exceptions/user_friendly_error.dart';
import '../../../../../shared/presenter/base/base_widget.dart';
import '../../../../movies/domains/entities/movie.dart';

class MinMaxWinnerIntervalProducersState extends Equatable {
  const MinMaxWinnerIntervalProducersState({
    this.behavior = AppBehavior.loading,
    this.value = const MinMaxWinnerIntervalProducer(max: [], min: []),
  });

  final AppBehavior behavior;
  final MinMaxWinnerIntervalProducer value;

  MinMaxWinnerIntervalProducersState copyWith({
    AppBehavior? behavior,
    MinMaxWinnerIntervalProducer? value,
  }) =>
      MinMaxWinnerIntervalProducersState(
        behavior: behavior ?? this.behavior,
        value: value ?? this.value,
      );

  @override
  List<Object?> get props => [behavior];
}

class InertMinMaxWinnerIntervalProducersState extends MinMaxWinnerIntervalProducersState {
  const InertMinMaxWinnerIntervalProducersState({super.behavior});
}

class FailedMinMaxWinnerIntervalProducersState extends MinMaxWinnerIntervalProducersState {
  const FailedMinMaxWinnerIntervalProducersState({required this.error})
      : super(behavior: AppBehavior.failed);

  final UserFriendlyError error;

  @override
  List<Object?> get props => [error, behavior];
}
