import 'package:equatable/equatable.dart';

abstract class MinMaxWinnerIntervalProducersEvent extends Equatable {
  const MinMaxWinnerIntervalProducersEvent();
}

class FetchMinMaxWinnerIntervalProducersEvent extends MinMaxWinnerIntervalProducersEvent {
  const FetchMinMaxWinnerIntervalProducersEvent();

  @override
  List<Object?> get props => [];
}

class RetryMinMaxWinnerIntervalProducersEvent extends MinMaxWinnerIntervalProducersEvent {
  const RetryMinMaxWinnerIntervalProducersEvent();

  @override
  List<Object?> get props => [];
}

class FailedMinMaxWinnerIntervalProducersEvent extends MinMaxWinnerIntervalProducersEvent {
  const FailedMinMaxWinnerIntervalProducersEvent();

  @override
  List<Object?> get props => [];
}
