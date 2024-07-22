import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';
import '../../../../di/app_injector.dart';
import '../../../../shared/presenter/organisms/cards/cards.dart';
import '../../../../shared/presenter/organisms/tables/tables.dart';
import '../controllers/top_studios_with_winners/bloc.dart';

class TopStudiosWithWinnersWidget extends StatelessWidget {
  const TopStudiosWithWinnersWidget({super.key, required this.constraints});

  final BoxConstraints constraints;

  @override
  Widget build(Object context) => BlocProvider<TopStudiosWithWinnersBloc>(
        create: (context) => appInjector.get<TopStudiosWithWinnersBloc>()
          ..add(const FetchTopStudiosWithWinnersEvent()),
        child: _Content(constraints: constraints),
      );
}

class _Content extends StatelessWidget {
  const _Content({required this.constraints});

  final BoxConstraints constraints;
  @override
  Widget build(Object context) =>
      BlocBuilder<TopStudiosWithWinnersBloc, TopStudiosWithWinnersState>(
        builder: (context, state) => AppCards.primary(
          title: S.current.topStudiosWithWinnersTitle,
          behavior: state.behavior,
          error: state is FailedTopStudiosWithWinnersState ? state.error : null,
          constraints: constraints,
          content: AppTables.primary(
            headers: [
              S.current.yearLabel,
              S.current.winnersOnlyLabel,
            ],
            content: state.values
                .map(
                  (item) => [
                    item.name,
                    item.winCount,
                  ],
                )
                .toList(),
          ),
          onRefresh: () => context
              .read<TopStudiosWithWinnersBloc>()
              .add(const RetryTopStudiosWithWinnersEvent()),
        ),
      );
}
