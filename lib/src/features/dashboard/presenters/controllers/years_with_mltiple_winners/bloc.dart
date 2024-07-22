import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../shared/externals/app_logger.dart';
import '../../../../../shared/presenter/base/base_widget.dart';
import '../../../../movies/domains/use_cases/fetch_winners_by_year_use_case.dart';
import '_event.dart';
import '_state.dart';

export '_event.dart';
export '_state.dart';

@injectable
class YearWithMulpleWinnerBloc extends Bloc<YearWithMulpleWinnerEvent, YearWithMulpleWinnerState> {
  YearWithMulpleWinnerBloc({required this.logger, required this.useCase})
      : super(const InertYearWithMulpleWinnerState()) {
    on<FetchYearWithMulpleWinnerEvent>(_onFetch);
    on<RetryYearWithMulpleWinnerEvent>(_onRetry);
  }

  final AppLogger logger;
  final FetchWinnersByYearUseCase useCase;

  FutureOr<void> _onFetch(
    FetchYearWithMulpleWinnerEvent event,
    Emitter<YearWithMulpleWinnerState> emit,
  ) async {
    emit(state.copyWith(behavior: AppBehavior.loading));

    final result = await useCase.fetch();
    result.fold(
      (error) => emit(
        FailedYearWithMulpleWinnerState(error: error),
      ),
      (value) => emit(
        state.copyWith(
          behavior: AppBehavior.normal,
          values: value,
        ),
      ),
    );
  }

  FutureOr<void> _onRetry(
    RetryYearWithMulpleWinnerEvent event,
    Emitter<YearWithMulpleWinnerState> emit,
  ) {
    add(const FetchYearWithMulpleWinnerEvent());
  }
}
