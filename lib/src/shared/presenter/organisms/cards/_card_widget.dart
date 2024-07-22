import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/themes/app_theme.dart';
import '../../atoms/gap.dart';
import '../../atoms/texts/texts.dart';
import '../../base/base_widget.dart';
import '../../base/styles/styles.dart';
import '../../molecules/buttons/icon_button/icon.dart';
import '../feedbacks.dart';
import '_card_styles.dart';

class AppCardWidget extends BaseAtomicWidget {
  const AppCardWidget({
    required this.styles,
    this.title = '',
    this.subtitle,
    required this.content,
    required this.onRefresh,
    this.header,
    this.constraints,
    super.key,
    super.error,
    super.behaviors = AppBehavior.all,
    super.behavior = AppBehavior.normal,
  });

  final StylesBuilder<CardStyles> styles;
  final String title;
  final String? subtitle;
  final Widget content;
  final Widget? header;
  final BoxConstraints? constraints;
  final void Function()? onRefresh;

  @override
  Widget onNormal(BuildContext context) {
    final style = styles(context).resolve(behavior);
    return DefaultTextStyle(
      style: TextStyle(color: style.color),
      child: Card(
        color: style.backgroundColor,
        elevation: 2,
        child: ConstrainedBox(
          constraints: constraints ??
              BoxConstraints.loose(
                const Size.fromHeight(200),
              ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppGaps.sm,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppGaps.md,
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: AppTheme.spacings.md,
                          ),
                          child: AppTexts.titleMedium(
                            title,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (behaviors.contains(AppBehavior.loading) ||
                          behaviors.contains(AppBehavior.failed))
                        AppIconButtons.primary(
                          icon: CupertinoIcons.refresh_bold,
                          onTap: onRefresh,
                          behavior: behavior,
                        ),
                      AppGaps.xxs,
                    ],
                  ),
                  if (header != null) header!,
                  if (subtitle != null) AppTexts.headlineSmall(subtitle!),
                  if (!behavior.isLoading)
                    Container(
                      padding: EdgeInsets.all(AppTheme.spacings.md),
                      width: double.infinity,
                      child: content,
                    ),
                  if (behavior.isFailed)
                    Center(
                      child: AppUserFeedbacks(
                        onTryAgain: onRefresh!,
                        error: error,
                      ),
                    ),
                ],
              ),
              if (behavior.isLoading)
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: style.color,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
