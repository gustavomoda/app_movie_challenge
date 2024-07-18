import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../shared/presenter/organisms/scafolds.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) => AppScaffolds.fullWithSafeArea(
        context,
        title: S.current.moviesLabel,
        body: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text('TODO'),
            ),
          ],
        ),
      );
}
