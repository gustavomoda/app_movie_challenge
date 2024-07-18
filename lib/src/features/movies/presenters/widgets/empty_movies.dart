import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';
import '../../../../shared/presenter/atoms/texts/texts.dart';
import '../controllers/movies_bloc.dart';

class EmptyMovies extends StatelessWidget {
  const EmptyMovies({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state is FetchedMoviesState &&
              state.movies.content.isEmpty &&
              state.movies.lastPage &&
              state.movies.totalPages == 0) {
            return Container(
              alignment: Alignment.center,
              child: AppTexts.displaySmall(
                S.current.moviesNotFoundMessage,
                color: Theme.of(context).colorScheme.error,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      );
}
