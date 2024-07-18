import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';
import '../../../../shared/presenter/atoms/gap.dart';
import '../../../../shared/presenter/atoms/texts/texts.dart';
import '../controllers/movies_bloc.dart';

class MovieFilter extends StatelessWidget {
  const MovieFilter({super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            AppGaps.xs,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _YearFilterInput(),
                _WinnerilterInput(),
              ],
            ),
            AppGaps.xs,
          ],
        ),
      );
}

class _YearFilterInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var year = DateTime.now().year;
    final items = <String>[
      S.current.all,
      ...List.generate(100, (index) => (year--).toString()),
    ]
        .map<DropdownMenuItem<String>>(
          (value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
        .toList();
    return Row(
      children: [
        AppTexts.labelLarge(S.current.yearLabel),
        AppGaps.xs,
        BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) => DropdownButton<String>(
            value: state.filter.year?.toString() ?? S.current.all,
            onChanged: (newValue) => context.read<MoviesBloc>().add(
                  FilterMovieEvent(
                    filter: context.read<MoviesBloc>().state.filter.copyWith(
                          year: newValue == S.current.all || (newValue?.isEmpty ?? true)
                              ? null
                              : int.parse(newValue!),
                        ),
                  ),
                ),
            items: items,
          ),
        ),
      ],
    );
  }
}

class _WinnerilterInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        children: [
          AppTexts.capiton(S.current.winnersOnlyLabel),
          BlocBuilder<MoviesBloc, MoviesState>(
            builder: (context, state) => Switch(
              value: state.filter.winner ?? false,
              onChanged: (newValue) {
                context.read<MoviesBloc>().add(
                      FilterMovieEvent(
                        filter: state.filter.copyWith(
                          winner: newValue ? newValue : null,
                        ),
                      ),
                    );
              },
            ),
          ),
        ],
      );
}
