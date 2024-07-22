import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';
import '../../../../di/app_injector.dart';
import '../../../../shared/presenter/base/base_widget.dart';
import '../../../../shared/presenter/molecules/text_field/text_fields.dart';
import '../../../../shared/presenter/organisms/cards/cards.dart';
import '../../../../shared/presenter/organisms/tables/tables.dart';
import '../controllers/winners_movies_by_years/bloc.dart';

class WinnersMoviesByYearsWidget extends StatelessWidget {
  const WinnersMoviesByYearsWidget({super.key, required this.constraints});

  final BoxConstraints constraints;

  @override
  Widget build(Object context) => BlocProvider<WinnersMoviesByYearsBloc>(
        create: (context) => appInjector.get<WinnersMoviesByYearsBloc>()
          ..add(FetchWinnersMoviesByYearsEvent(year: DateTime.now().year)),
        child: _Content(constraints: constraints),
      );
}

class _Content extends StatelessWidget {
  const _Content({required this.constraints});

  final BoxConstraints constraints;
  @override
  Widget build(Object context) => AppCards.primary(
        title: S.current.winnersMoviesByYearsTitle,
        behaviors: AppBehavior.onlyNornal,
        constraints: constraints,
        header: const _YearInput(),
        content: BlocBuilder<WinnersMoviesByYearsBloc, WinnersMoviesByYearsState>(
          builder: (context, state) => AppTables.primary(
            behavior: state.behavior,
            emptyText: S.current.moviesNotFoundMessage,
            error: state is FailedWinnersMoviesByYearsState ? state.error : null,
            headers: [
              S.current.titleLabel,
              S.current.yearLabel,
              S.current.idLabel,
            ],
            content: state.values
                .map(
                  (item) => [
                    item.title,
                    item.year,
                    item.id,
                  ],
                )
                .toList(),
            onRefresh: () => context
                .read<WinnersMoviesByYearsBloc>()
                .add(const RetryWinnersMoviesByYearsEvent()),
          ),
        ),
      );
}

class _YearInput extends StatefulWidget {
  const _YearInput();

  @override
  State<_YearInput> createState() => _YearInputState();
}

class _YearInputState extends State<_YearInput> {
  TextEditingController controller = TextEditingController();

  AppBehavior behavior = AppBehavior.normal;

  @override
  void initState() {
    super.initState();
    final currentState = context.read<WinnersMoviesByYearsBloc>().state;
    controller = TextEditingController(
      text: currentState.year.toString(),
    );
    behavior = currentState.behavior;
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<WinnersMoviesByYearsBloc, WinnersMoviesByYearsState>(
        listener: (context, state) {
          setState(() {
            behavior = state.behavior;
          });
        },
        child: AppTextFields.year(
          controller: controller,
          readOnly: behavior.isLoading,
          onEditingComplete: search,
          onValid: search,
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: search,
          ),
        ),
      );

  void search([String? value]) {
    if (behavior.isLoading) {
      return;
    }
    final year = int.tryParse(value ?? controller.text);
    if (year == null) {
      return;
    }
    context.read<WinnersMoviesByYearsBloc>().add(FetchWinnersMoviesByYearsEvent(year: year));
  }
}
