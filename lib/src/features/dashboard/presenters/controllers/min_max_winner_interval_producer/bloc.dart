import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../shared/externals/app_logger.dart';
import '../../../../../shared/presenter/base/base_widget.dart';
import '../../../../movies/domains/use_cases/min_max_winner_interval_producer.dart';
import '_event.dart';
import '_state.dart';

export '_event.dart';
export '_state.dart';

@injectable
class MinMaxWinnerIntervalProducersBloc
    extends Bloc<MinMaxWinnerIntervalProducersEvent, MinMaxWinnerIntervalProducersState> {
  MinMaxWinnerIntervalProducersBloc({required this.logger, required this.useCase})
      : super(const InertMinMaxWinnerIntervalProducersState()) {
    on<FetchMinMaxWinnerIntervalProducersEvent>(_onFetch);
    on<RetryMinMaxWinnerIntervalProducersEvent>(_onRetry);
  }

  final AppLogger logger;
  final MinMaxWinnerIntervalProducerUseCase useCase;

  FutureOr<void> _onFetch(
    FetchMinMaxWinnerIntervalProducersEvent event,
    Emitter<MinMaxWinnerIntervalProducersState> emit,
  ) async {
    emit(state.copyWith(behavior: AppBehavior.loading));

    final result = await useCase.fetch();
    result.fold(
      (error) => emit(
        FailedMinMaxWinnerIntervalProducersState(error: error),
      ),
      (value) => emit(
        state.copyWith(
          behavior: AppBehavior.normal,
          value: value,
        ),
      ),
    );
  }

  FutureOr<void> _onRetry(
    RetryMinMaxWinnerIntervalProducersEvent event,
    Emitter<MinMaxWinnerIntervalProducersState> emit,
  ) {
    add(const FetchMinMaxWinnerIntervalProducersEvent());
  }
}
