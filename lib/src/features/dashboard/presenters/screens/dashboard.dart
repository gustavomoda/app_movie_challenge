import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../config/themes/app_theme.dart';
import '../../../../shared/presenter/organisms/scafolds.dart';
import '../widgets/min_max_winner_interval_producers.dart';
import '../widgets/top_studios_with_winners.dart';
import '../widgets/winners_movies_by_years.dart';
import '../widgets/years_with_mltiple_winners.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final constraints = BoxConstraints(
      minHeight: 200,
      maxWidth: (width > 640 ? width * 0.4 : width) - AppTheme.spacings.lg,
    );
    return AppScaffolds.fullWithSafeArea(
      context,
      title: S.current.dashboardLabel,
      body: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: AppTheme.spacings.lg,
          children: [
            WinnersMoviesByYearsWidget(constraints: constraints),
            YearsWithMultipleWinnersWidget(constraints: constraints),
            TopStudiosWithWinnersWidget(constraints: constraints),
            MinMaxWinnerIntervalProducersWidget(constraints: constraints),
            TopStudiosWithWinnersWidget(constraints: constraints),
          ],
        ),
      ),
    );
  }
}
