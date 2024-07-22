import 'package:equatable/equatable.dart';

import '../../../../../shared/exceptions/user_friendly_error.dart';
import '../../../../../shared/presenter/base/base_widget.dart';
import '../../../../movies/domains/entities/movie.dart';

class WinnersMoviesByYearsState extends Equatable {
  WinnersMoviesByYearsState({
    int? year,
    this.behavior = AppBehavior.loading,
    this.values = const [],
  }) : year = year ?? DateTime.now().year;

  final AppBehavior behavior;
  final int year;
  final List<Movie> values;

  WinnersMoviesByYearsState copyWith({
    int? year,
    AppBehavior? behavior,
    List<Movie>? values,
  }) =>
      WinnersMoviesByYearsState(
        year: year ?? this.year,
        behavior: behavior ?? this.behavior,
        values: values ?? this.values,
      );

  @override
  List<Object?> get props => [behavior];
}

class InertWinnersMoviesByYearsState extends WinnersMoviesByYearsState {
  InertWinnersMoviesByYearsState({super.behavior});
}

class FailedWinnersMoviesByYearsState extends WinnersMoviesByYearsState {
  FailedWinnersMoviesByYearsState({required this.error}) : super(behavior: AppBehavior.failed);

  final UserFriendlyError error;

  @override
  List<Object?> get props => [error, behavior];
}
