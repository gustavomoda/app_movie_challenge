import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../config/themes/app_theme.dart';
import '../../exceptions/user_friendly_error.dart';
import '../atoms/gap.dart';
import '../atoms/texts/texts.dart';
import 'scafolds.dart';

class AppUserFeedbacks extends StatelessWidget {
  const AppUserFeedbacks({
    super.key,
    required this.error,
    required this.onTryAgain,
  });

  final UserFriendlyError? error;
  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) {
    if (error == null) {
      return const SizedBox.shrink();
    }
    final color = error!.map(
      info: (_) => Colors.blue,
      warning: (_) => Colors.red,
      fatal: (_) => Colors.red,
      error: (_) => Colors.red,
    );
    return Container(
      padding: EdgeInsets.all(AppTheme.spacings.lg),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AppGaps.lg,
          Icon(
            error!.map(
              info: (_) => Icons.info_outline_rounded,
              warning: (_) => Icons.warning_amber_rounded,
              fatal: (_) => Icons.error_outline,
              error: (_) => Icons.error_outline_rounded,
            ),
            color: color,
            size: MediaQuery.of(context).size.height * 0.2,
          ),
          AppGaps.lg,
          AppTexts.headlineSmall(
            error!.title,
            textAlign: TextAlign.center,
            color: color,
          ),
          AppGaps.lg,
          AppTexts.bodyLarge(
            error!.message,
            textAlign: TextAlign.center,
          ),
          AppGaps.lg,
          ElevatedButton(
            onPressed: onTryAgain,
            child: Text(
              S.of(context).tryAgainButtonLabel,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  static Future<T?> openDialog<T>(
    final BuildContext context,
    final UserFriendlyError? error,
    final VoidCallback onTryAgain,
  ) =>
      showDialog<T>(
        context: context,
        barrierDismissible: false,
        useSafeArea: false,
        useRootNavigator: false,
        builder: (_) => AppScaffolds.raw(
          body: AppUserFeedbacks(
            error: error,
            onTryAgain: () {
              onTryAgain();
              Navigator.of(context).pop();
            },
          ),
        ),
      );
}
