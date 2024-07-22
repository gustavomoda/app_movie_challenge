import 'package:equatable/equatable.dart';

abstract class WinnersMoviesByYearsEvent extends Equatable {
  const WinnersMoviesByYearsEvent();
}

class FetchWinnersMoviesByYearsEvent extends WinnersMoviesByYearsEvent {
  const FetchWinnersMoviesByYearsEvent({required this.year});

  final int year;

  @override
  List<Object?> get props => [];
}

class RetryWinnersMoviesByYearsEvent extends WinnersMoviesByYearsEvent {
  const RetryWinnersMoviesByYearsEvent();

  @override
  List<Object?> get props => [];
}

class FailedWinnersMoviesByYearsEvent extends WinnersMoviesByYearsEvent {
  const FailedWinnersMoviesByYearsEvent();

  @override
  List<Object?> get props => [];
}
