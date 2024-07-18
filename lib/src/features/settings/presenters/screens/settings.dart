import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';
import '../../../../config/themes/app_theme.dart';
import '../../../../shared/i10n/app_locale.dart';
import '../../../../shared/presenter/atoms/gap.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLang = context.watch<AppLocale>().current;
    return PopScope(
      onPopInvoked: (value) => value,
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.current.settingsLabel),
        ),
        body: ListView(
          children: [
            AppGaps.lg,
            SwitchListTile(
              title: Text(S.current.darkMode),
              value: context.watch<AppTheme>().isDarkMode,
              onChanged: (value) {
                context.read<AppTheme>().toogleTheme(context);
              },
            ),
            AppGaps.md,
            const Divider(),
            AppGaps.md,
            ...context.watch<AppLocale>().supportedLocales.map(
                  (e) => SwitchListTile(
                    title: Text(context.read<AppLocale>().getLanguageName(e)),
                    subtitle: Text(
                      '${context.read<AppLocale>().currentAstagl10n()} = ${context.read<AppLocale>().toTagl10n(e)}${currentLang.toLanguageTag()}' ==
                              e.toLanguageTag()
                          ? 'Selected'
                          : '',
                    ),
                    value: currentLang.toLanguageTag() == e.toLanguageTag(),
                    onChanged: (_) {
                      unawaited(context.read<AppLocale>().change(e));
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
