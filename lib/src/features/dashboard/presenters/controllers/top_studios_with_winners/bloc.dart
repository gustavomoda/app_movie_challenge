import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../shared/externals/app_logger.dart';
import '../../../../../shared/presenter/base/base_widget.dart';
import '../../../../movies/domains/use_cases/top_studios_with_winners_use_case.dart';
import '_event.dart';
import '_state.dart';

export '_event.dart';
export '_state.dart';

@injectable
class TopStudiosWithWinnersBloc
    extends Bloc<TopStudiosWithWinnersEvent, TopStudiosWithWinnersState> {
  TopStudiosWithWinnersBloc({required this.logger, required this.useCase})
      : super(const InertTopStudiosWithWinnersState()) {
    on<FetchTopStudiosWithWinnersEvent>(_onFetch);
    on<RetryTopStudiosWithWinnersEvent>(_onRetry);
  }

  final AppLogger logger;
  final TopStudiosWithWinnersUseCase useCase;

  FutureOr<void> _onFetch(
    FetchTopStudiosWithWinnersEvent event,
    Emitter<TopStudiosWithWinnersState> emit,
  ) async {
    emit(state.copyWith(behavior: AppBehavior.loading));

    final result = await useCase.fetch();
    result.fold(
      (error) => emit(
        FailedTopStudiosWithWinnersState(error: error),
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
    RetryTopStudiosWithWinnersEvent event,
    Emitter<TopStudiosWithWinnersState> emit,
  ) {
    add(const FetchTopStudiosWithWinnersEvent());
  }
}
