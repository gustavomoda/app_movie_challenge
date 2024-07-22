import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../shared/externals/app_logger.dart';
import '../../../../../shared/presenter/base/base_widget.dart';
import '../../../../movies/domains/use_cases/winners_movies_by_years_use_case.dart';
import '_event.dart';
import '_state.dart';

export '_event.dart';
export '_state.dart';

@injectable
class WinnersMoviesByYearsBloc extends Bloc<WinnersMoviesByYearsEvent, WinnersMoviesByYearsState> {
  WinnersMoviesByYearsBloc({required this.logger, required this.useCase})
      : super(InertWinnersMoviesByYearsState()) {
    on<FetchWinnersMoviesByYearsEvent>(_onFetch);
    on<RetryWinnersMoviesByYearsEvent>(_onRetry);
  }

  final AppLogger logger;
  final WinnersMoviesByYearsUseCase useCase;

  FutureOr<void> _onFetch(
    FetchWinnersMoviesByYearsEvent event,
    Emitter<WinnersMoviesByYearsState> emit,
  ) async {
    emit(state.copyWith(behavior: AppBehavior.loading));

    final result = await useCase.fetch(year: event.year);
    result.fold(
      (error) => emit(FailedWinnersMoviesByYearsState(error: error)),
      (value) => emit(
        state.copyWith(
          behavior: AppBehavior.normal,
          values: value,
        ),
      ),
    );
  }

  FutureOr<void> _onRetry(
    RetryWinnersMoviesByYearsEvent event,
    Emitter<WinnersMoviesByYearsState> emit,
  ) {
    add(FetchWinnersMoviesByYearsEvent(year: state.year));
  }
}
