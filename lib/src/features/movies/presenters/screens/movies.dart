import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';
import '../../../../di/app_injector.dart';
import '../../../../shared/presenter/organisms/scafolds.dart';
import '../controllers/movies_bloc.dart';
import '../widgets/movies_filter.dart';
import '../widgets/movies_list.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => appInjector.get<MoviesBloc>()..add(const FetchMovieEvent()),
        child: BlocProvider(
          create: (context) => appInjector.get<MoviesBloc>()..add(const FetchMovieEvent()),
          child: AppScaffolds.fullWithSafeArea(
            context,
            title: S.current.moviesLabel,
            bottomAppBar: const PreferredSize(
              preferredSize: Size.fromHeight(30),
              child: MovieFilter(),
            ),
            body: const MoviesListView(),
          ),
        ),
      );
}
