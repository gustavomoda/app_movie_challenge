import 'package:equatable/equatable.dart';

abstract class TopStudiosWithWinnersEvent extends Equatable {
  const TopStudiosWithWinnersEvent();
}

class FetchTopStudiosWithWinnersEvent extends TopStudiosWithWinnersEvent {
  const FetchTopStudiosWithWinnersEvent();

  @override
  List<Object?> get props => [];
}

class RetryTopStudiosWithWinnersEvent extends TopStudiosWithWinnersEvent {
  const RetryTopStudiosWithWinnersEvent();

  @override
  List<Object?> get props => [];
}

class FailedTopStudiosWithWinnersEvent extends TopStudiosWithWinnersEvent {
  const FailedTopStudiosWithWinnersEvent();

  @override
  List<Object?> get props => [];
}
