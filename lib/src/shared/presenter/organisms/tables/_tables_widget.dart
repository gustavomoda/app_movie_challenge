import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../config/themes/app_theme.dart';
import '../../atoms/texts/texts.dart';
import '../../base/base_widget.dart';
import '../../base/styles/styles.dart';
import '../feedbacks.dart';
import '_tables_styles.dart';

class AppTableWidget extends BaseAtomicWidget {
  const AppTableWidget({
    required this.styles,
    required this.headers,
    required this.content,
    this.emptyText,
    this.onRefresh,
    super.key,
    super.error,
    super.behaviors = AppBehavior.all,
    super.behavior = AppBehavior.normal,
  });

  final StylesBuilder<TableStyles> styles;
  final List<String> headers;
  final List<List<dynamic>> content;
  final String? emptyText;
  final void Function()? onRefresh;

  @override
  Widget onNormal(BuildContext context) {
    final style = styles(context).resolve(behavior);
    final body = Table(
      border: TableBorder.all(
        color: style.borderColor,
        width: style.borderWidth,
      ),
      children: [
        TableRow(children: headers.map(_CellHeader.new).toList()),
        ...content.map(
          (row) => TableRow(
            // ignore: unnecessary_lambdas
            children: row.map((d) => _CellData(d)).toList(),
          ),
        ),
      ],
    );
    if (behaviors.contains(AppBehavior.loading) && behavior.isLoading) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(AppTheme.spacings.lg),
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    if (behaviors.contains(AppBehavior.failed) && behavior.isFailed) {
      return AppUserFeedbacks(
        error: error,
        onTryAgain: onRefresh ?? () {},
      );
    }
    if (emptyText?.isNotEmpty ?? false == true) {
      return Column(
        children: [
          body,
          Padding(
            padding: EdgeInsets.all(AppTheme.spacings.lg),
            child: AppTexts.bodyLarge(emptyText!),
          ),
        ],
      );
    }
    return body;
  }
}

class _CellHeader extends StatelessWidget {
  const _CellHeader(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => TableCell(
        child: Padding(
          padding: EdgeInsets.all(AppTheme.spacings.xs),
          child: AppTexts.bodyMedium(
            text,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
        ),
      );
}

class _CellData extends StatelessWidget {
  const _CellData(this.text);
  final dynamic text;

  @override
  Widget build(BuildContext context) {
    TextAlign? textAlign;
    String data;
    if (text is int) {
      data = S.of(context).displayInteger(text);
      textAlign = TextAlign.right;
    } else if (text is double) {
      data = S.of(context).displayDecimal(text);
      textAlign = TextAlign.right;
    } else {
      data = text;
    }
    return TableCell(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.spacings.xs),
        child: AppTexts.bodyMedium(
          data,
          textAlign: textAlign,
        ),
      ),
    );
  }
}
