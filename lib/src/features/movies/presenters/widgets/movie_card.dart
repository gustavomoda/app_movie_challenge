import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../shared/presenter/atoms/gap.dart';
import '../../../../shared/presenter/atoms/texts/texts.dart';
import '../../domains/entities/movie.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});

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
                _MovieIconAndYear(movie: movie),
                _MovieData(movie: movie),
              ],
            ),
          ),
        ),
      );
}

class _MovieData extends StatelessWidget {
  const _MovieData({required this.movie});

  final Movie movie;
  @override
  Widget build(BuildContext context) => Padding(
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
      );
}

class _MovieIconAndYear extends StatelessWidget {
  const _MovieIconAndYear({required this.movie});

  final Movie movie;
  @override
  Widget build(BuildContext context) => Expanded(
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
