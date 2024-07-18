import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/movies_bloc.dart';

class LoadingMovies extends StatelessWidget {
  const LoadingMovies({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<MoviesBloc, MoviesState>(
        buildWhen: (previous, current) {
          if (current is FetchingMoviesState || previous is FetchingMoviesState) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state is FetchingMoviesState) {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox.shrink();
        },
      );
}
