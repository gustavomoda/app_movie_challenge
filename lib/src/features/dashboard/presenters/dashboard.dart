import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../shared/presenter/organisms/scafolds.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => AppScaffolds.fullWithSafeArea(
        context,
        title: S.current.dashboardLabel,
        body: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('TODO'),
            ),
            Text(
              '${DateTime.now()}',
            ),
          ],
        ),
      );
}
