import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';
import '../../../../di/app_injector.dart';
import '../../../../shared/presenter/base/base_widget.dart';
import '../../../../shared/presenter/organisms/cards/cards.dart';
import '../../../../shared/presenter/organisms/tables/tables.dart';
import '../controllers/years_with_mltiple_winners/bloc.dart';

class YearsWithMultipleWinnersWidget extends StatelessWidget {
  const YearsWithMultipleWinnersWidget({super.key, required this.constraints});

  final BoxConstraints constraints;

  @override
  Widget build(Object context) => BlocProvider<YearWithMulpleWinnerBloc>(
        create: (context) => appInjector.get<YearWithMulpleWinnerBloc>()
          ..add(const FetchYearWithMulpleWinnerEvent()),
        child: _Content(constraints: constraints),
      );
}

class _Content extends StatelessWidget {
  const _Content({required this.constraints});

  final BoxConstraints constraints;
  @override
  Widget build(Object context) => BlocBuilder<YearWithMulpleWinnerBloc, YearWithMulpleWinnerState>(
        builder: (context, state) => AppCards.primary(
          title: S.current.yearsWithMultipleWinnersTitle,
          behavior: state.behavior,
          error: state is FailedYearWithMulpleWinnerState ? state.error : null,
          constraints: constraints,
          content: AppTables.primary(
            behaviors: AppBehavior.onlyNornal,
            headers: [S.current.yearLabel, S.current.winnersOnlyLabel],
            content: state.values
                .map(
                  (item) => [
                    item.year.toString(),
                    item.winnerCount,
                  ],
                )
                .toList(),
          ),
          onRefresh: () =>
              context.read<YearWithMulpleWinnerBloc>().add(const RetryYearWithMulpleWinnerEvent()),
        ),
      );
}
