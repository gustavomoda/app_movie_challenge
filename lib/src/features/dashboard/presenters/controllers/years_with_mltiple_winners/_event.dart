import 'package:equatable/equatable.dart';

abstract class YearWithMulpleWinnerEvent extends Equatable {
  const YearWithMulpleWinnerEvent();
}

class FetchYearWithMulpleWinnerEvent extends YearWithMulpleWinnerEvent {
  const FetchYearWithMulpleWinnerEvent();

  @override
  List<Object?> get props => [];
}

class RetryYearWithMulpleWinnerEvent extends YearWithMulpleWinnerEvent {
  const RetryYearWithMulpleWinnerEvent();

  @override
  List<Object?> get props => [];
}
