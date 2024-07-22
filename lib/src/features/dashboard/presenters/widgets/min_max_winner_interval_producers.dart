import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';
import '../../../../di/app_injector.dart';
import '../../../../shared/presenter/atoms/gap.dart';
import '../../../../shared/presenter/atoms/texts/texts.dart';
import '../../../../shared/presenter/organisms/cards/cards.dart';
import '../../../../shared/presenter/organisms/tables/tables.dart';
import '../../../movies/domains/entities/movie.dart';
import '../controllers/min_max_winner_interval_producer/bloc.dart';

class MinMaxWinnerIntervalProducersWidget extends StatelessWidget {
  const MinMaxWinnerIntervalProducersWidget({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  Widget build(Object context) => BlocProvider<MinMaxWinnerIntervalProducersBloc>(
        create: (context) => appInjector.get<MinMaxWinnerIntervalProducersBloc>()
          ..add(const FetchMinMaxWinnerIntervalProducersEvent()),
        child: _Content(constraints: constraints),
      );
}

class _Content extends StatelessWidget {
  const _Content({required this.constraints});

  final BoxConstraints constraints;
  @override
  Widget build(Object context) =>
      BlocBuilder<MinMaxWinnerIntervalProducersBloc, MinMaxWinnerIntervalProducersState>(
        builder: (context, state) => AppCards.primary(
          title: S.current.minMaxWinnerIntervalProducersTitle,
          behavior: state.behavior,
          error: state is FailedMinMaxWinnerIntervalProducersState ? state.error : null,
          constraints: constraints,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTexts.bodyLarge(S.current.maximumLabel),
              _MinMaxTable(values: state.value.min),
              AppGaps.lg,
              AppTexts.bodyLarge(S.current.minimumLabel),
              _MinMaxTable(values: state.value.max),
            ],
          ),
          onRefresh: () => context
              .read<MinMaxWinnerIntervalProducersBloc>()
              .add(const RetryMinMaxWinnerIntervalProducersEvent()),
        ),
      );
}

class _MinMaxTable extends StatelessWidget {
  const _MinMaxTable({required this.values});

  final List<WinnerIntervalProducer> values;
  @override
  Widget build(BuildContext context) => AppTables.primary(
        headers: [
          S.current.producerLabel,
          S.current.intervalLabel,
          S.current.previewYearLabel,
          S.current.followingYearLabel,
        ],
        content: values
            .map(
              (item) => [
                item.producer,
                item.interval,
                item.previousWin,
                item.followingWin,
              ],
            )
            .toList(),
      );
}
