import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../main/presenters/widgets/app_icon.dart';
import '../../../../shared/presenter/atoms/texts/texts.dart';

class AppAboutDialog extends AboutDialog {
  AppAboutDialog({super.key})
      : super(
          applicationIcon: const AppIcon(),
          applicationVersion: '1.0.0',
          applicationName: S.current.appName,
          children: [
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: AppTexts.labelSmall(S.current.developerLabel),
                    subtitle: const AppTexts.bodyMedium('Gustavo Moda'),
                  ),
                  ListTile(
                    title: AppTexts.labelSmall(S.current.licenseLabel),
                    subtitle: Text(
                      S.current.licenseInfo,
                    ),
                  ),
                  ListTile(
                    title: AppTexts.labelSmall(S.current.dataSourceLabel),
                    subtitle: AppTexts.bodyMedium(
                      S.current.dataProvidedBy,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

  static Future<void> show(BuildContext context) async => showDialog<void>(
        context: context,
        builder: (context) => AppAboutDialog(),
      );
}
