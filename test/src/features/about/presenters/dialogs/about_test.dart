import 'package:app_movie_challenge/generated/l10n.dart';
import 'package:app_movie_challenge/src/features/about/presenters/dialogs/about.dart';
import 'package:app_movie_challenge/src/main/presenters/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../flutter_test_config.dart';

void main() {
  group('AppAboutDialog Widget Tests', () {
    testWidgets('should render AboutDialog correctly', (tester) async {
      // Act
      await tester.pumpWidget(wrapperMaterialAppForTest(AppAboutDialog()));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(AppAboutDialog), findsOneWidget);
      expect(find.byType(AppIcon), findsOneWidget);
    });
  });
}
