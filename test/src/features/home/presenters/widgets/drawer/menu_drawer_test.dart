import 'package:app_movie_challenge/generated/l10n.dart';
import 'package:app_movie_challenge/src/features/home/domain/entities/app_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppMenu Widget Tests:', () {
    testWidgets('dashboardItem should render correctly', (tester) async {
      final item = AppMenu.dashboardItem;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListTile(
              leading: Icon(item.icon),
              title: Text(item.label),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.text(S.current.dashboardLabel), findsOneWidget);
    });

    testWidgets('moviesItem should render correctly', (tester) async {
      final item = AppMenu.moviesItem;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ListTile(
            leading: Icon(item.icon),
            title: Text(item.label),
          ),
        ),
      ));

      expect(find.byIcon(Icons.movie), findsOneWidget);
      expect(find.text(S.current.moviesLabel), findsOneWidget);
    });

    testWidgets('settingsItem should render correctly', (tester) async {
      final item = AppMenu.settingsItem;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ListTile(
            leading: Icon(item.icon),
            title: Text(item.label),
          ),
        ),
      ));

      expect(find.byIcon(Icons.settings), findsOneWidget);
      expect(find.text(S.current.settingsLabel), findsOneWidget);
    });

    testWidgets('openMenuItem should render correctly', (tester) async {
      final item = AppMenu.openMenuItem;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ListTile(
            leading: Icon(item.icon),
            title: Text(item.label),
          ),
        ),
      ));

      expect(find.byIcon(Icons.menu), findsOneWidget);
      expect(find.text(S.current.menuLabel), findsOneWidget);
    });

    testWidgets('aboutMenu should render correctly', (tester) async {
      final item = AppMenu.aboutMenu;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ListTile(
            leading: Icon(item.icon),
            title: Text(item.label),
          ),
        ),
      ));

      expect(find.byIcon(Icons.info), findsOneWidget);
      expect(find.text(S.current.aboutLabel), findsOneWidget);
    });

    testWidgets('developerShowCaseItemMenu should render correctly', (tester) async {
      final item = AppMenu.developerShowCaseItemMenu;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ListTile(
            leading: Icon(item.icon),
            title: Text(item.label),
          ),
        ),
      ));

      expect(find.byIcon(Icons.developer_mode), findsOneWidget);
      expect(find.text(S.current.developThemeShowcase), findsOneWidget);
    });

    testWidgets('navigatorItems should contain correct items', (tester) async {
      final items = AppMenu.navigatorItems;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ListView(
            children: items
                .map((item) => ListTile(
                      leading: Icon(item.icon),
                      title: Text(item.label),
                    ))
                .toList(),
          ),
        ),
      ));

      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.text(S.current.dashboardLabel), findsOneWidget);

      expect(find.byIcon(Icons.movie), findsOneWidget);
      expect(find.text(S.current.moviesLabel), findsOneWidget);

      expect(find.byIcon(Icons.settings), findsOneWidget);
      expect(find.text(S.current.settingsLabel), findsOneWidget);

      expect(find.byIcon(Icons.menu), findsOneWidget);
      expect(find.text(S.current.menuLabel), findsOneWidget);
    });

    testWidgets('drawerMenuItemItems should contain correct items', (tester) async {
      final items = AppMenu.drawerMenuItemItems;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ListView(
            children: items
                .map((item) => ListTile(
                      leading: Icon(item.icon),
                      title: Text(item.label),
                    ))
                .toList(),
          ),
        ),
      ));

      expect(find.byIcon(Icons.settings), findsOneWidget);
      expect(find.text(S.current.settingsLabel), findsOneWidget);

      expect(find.byIcon(Icons.info), findsOneWidget);
      expect(find.text(S.current.aboutLabel), findsOneWidget);

      if (kDebugMode) {
        expect(find.byIcon(Icons.developer_mode), findsOneWidget);
        expect(find.text(S.current.developThemeShowcase), findsOneWidget);
      }
    });
  });
}
