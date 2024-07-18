import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';
import '../../../../shared/presenter/atoms/gap.dart';
import '../../../../shared/presenter/atoms/texts/texts.dart';
import '../../../../shared/presenter/organisms/feedbacks.dart';
import '../../domains/entities/movie.dart';
import '../controllers/movies_bloc.dart';
import 'empty_movies.dart';
import 'loading_movies.dart';

class MoviesListView extends StatefulWidget {
  const MoviesListView({super.key});

  @override
  _MoviesListViewState createState() => _MoviesListViewState();
}

class _MoviesListViewState extends State<MoviesListView> with AutomaticKeepAliveClientMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<Movie> _movies = [];
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _scrollListener() async {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.7 &&
        !isLoading) {
      isLoading = true;
      context.read<MoviesBloc>().add(FetchMoreMovieEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<MoviesBloc, MoviesState>(
      listenWhen: (previous, current) =>
          previous != current &&
          (current is FetchedMoviesState ||
              current is FailedFetchMoviesState ||
              current is FetchingMoviesState ||
              previous.movies != current.movies),
      listener: (context, state) async {
        if (state is FailedFetchMoviesState) {
          await AppUserFeedbacks.openDialog(context, state.error, () {
            context.read<MoviesBloc>().add(RetryMovieEvent());
          });
        } else if (state is FetchingMoviesState) {
          _cleanListIfFirstPageOrEmpty(state);
          setState(() {
            isLoading = true;
          });
        } else if (state is FetchedMoviesState) {
          setState(() {
            isLoading = false;
          });
          _cleanListIfFirstPageOrEmpty(state);
          if (state.movies.content.isEmpty) {
            return;
          }
          final oldCount = _movies.length;
          setState(() {
            _movies.addAll(state.movies.content);
          });
          for (var i = oldCount; i < _movies.length; i++) {
            _listKey.currentState?.insertItem(i);
          }
        }
      },
      child: Stack(
        children: [
          if (_movies.isNotEmpty)
            AnimatedList(
              key: _listKey,
              controller: _scrollController,
              initialItemCount: _movies.length,
              itemBuilder: (context, index, animation) {
                final movie = _movies[index];

                final curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                );

                final fadeAnimation = Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(curvedAnimation);

                return FadeTransition(
                  opacity: fadeAnimation,
                  child: MovieTile(movie: movie),
                );
              },
            ),
          const Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: LoadingMovies(),
          ),
          const Positioned(child: EmptyMovies()),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _cleanListIfFirstPageOrEmpty(MoviesState state) {
    if (state.filter.page == 0 && _movies.isNotEmpty) {
      _listKey.currentState?.removeAllItems((context, animation) => Container());
      setState(_movies.clear);
      _scrollController.jumpTo(0);
    }
  }
}

class MovieTile extends StatelessWidget {
  const MovieTile({super.key, required this.movie});

  final Movie movie;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Card(
          key: ValueKey(movie.id),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        movie.winner ? Icons.emoji_events : Icons.movie,
                        color: movie.winner
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                        size: 50,
                      ),
                      AppGaps.xxs,
                      AppTexts.labelLarge(
                        movie.year.toString(),
                        fontWeight: FontWeight.bold,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTexts.labelLarge(
                        movie.title,
                        fontWeight: FontWeight.bold,
                        maxLines: 2,
                      ),
                      AppGaps.xs,
                      _RowValue(
                        label: S.current.producersLabel(movie.producers.length),
                        value: movie.producers,
                      ),
                      _RowValue(
                        label: S.current.studiosLabel(movie.studios.length),
                        value: movie.studios,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class _RowValue extends StatelessWidget {
  const _RowValue({required this.label, required this.value});

  final String label;
  final dynamic value;

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTexts.capiton(label),
          Expanded(
            child: AppTexts.labelSmall(
              value is List ? value.join(', ') : value,
              fontWeight: FontWeight.bold,
              maxLines: 2,
            ),
          ),
        ],
      );
}
