import 'package:app_movie_challenge/generated/l10n.dart';
import 'package:app_movie_challenge/src/features/about/presenters/dialogs/about.dart';
import 'package:app_movie_challenge/src/main/presenters/widgets/app_icon.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../flutter_test_config.dart';

void main() {
  group('AppAboutDialog Widget Tests', () {
    testWidgets('should render AboutDialog correctly', (tester) async {
      await tester.pumpWidget(wrapperMaterialAppForTest(AppAboutDialog()));
      await tester.pumpAndSettle();

      expect(find.byType(AppAboutDialog), findsOneWidget);
      expect(find.byType(AppIcon), findsOneWidget);

      expect(find.text(S.current.appName), findsOneWidget);
      expect(find.text(S.current.developerLabel), findsOneWidget);
      expect(find.text(S.current.licenseLabel), findsOneWidget);
      expect(find.text(S.current.licenseInfo), findsOneWidget);
      expect(find.text(S.current.dataSourceLabel), findsOneWidget);
      expect(find.text(S.current.dataProvidedBy), findsOneWidget);
    });
  });
}
