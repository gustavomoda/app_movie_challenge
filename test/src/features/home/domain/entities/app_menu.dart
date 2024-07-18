import 'package:app_movie_challenge/generated/l10n.dart';
import 'package:app_movie_challenge/src/config/routes/app_route.dart';
import 'package:app_movie_challenge/src/features/home/domain/entities/app_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppMenu:', () {
    test('dashboardItem should have correct properties', () {
      final item = AppMenu.dashboardItem;

      expect(item.icon, equals(Icons.home));
      expect(item.label, equals(S.current.dashboardLabel));
      expect(item.route, equals(AppRoutes.home));
    });

    test('moviesItem should have correct properties', () {
      final item = AppMenu.moviesItem;

      expect(item.icon, equals(Icons.movie));
      expect(item.label, equals(S.current.moviesLabel));
      expect(item.route, equals(AppRoutes.home));
    });

    test('settingsItem should have correct properties', () {
      final item = AppMenu.settingsItem;

      expect(item.icon, equals(Icons.settings));
      expect(item.label, equals(S.current.settingsLabel));
      expect(item.route, equals(AppRoutes.settings));
    });

    test('openMenuItem should have correct properties', () {
      final item = AppMenu.openMenuItem;

      expect(item.icon, equals(Icons.menu));
      expect(item.label, equals(S.current.menuLabel));
      expect(item.route, isNull);
    });

    test('aboutMenu should have correct properties', () {
      final item = AppMenu.aboutMenu;

      expect(item.icon, equals(Icons.info));
      expect(item.label, equals(S.current.aboutLabel));
      expect(item.route, isNull);
    });

    test('developerShowCaseItemMenu should have correct properties', () {
      final item = AppMenu.developerShowCaseItemMenu;

      expect(item.icon, equals(Icons.developer_mode));
      expect(item.label, equals(S.current.developThemeShowcase));
      expect(item.route, equals(AppRoutes.developShowcase));
    });

    test('navigatorItems should contain correct items', () {
      final items = AppMenu.navigatorItems;

      expect(items, contains(AppMenu.dashboardItem));
      expect(items, contains(AppMenu.moviesItem));
      expect(items, contains(AppMenu.settingsItem));
      expect(items, contains(AppMenu.openMenuItem));
    });

    test('drawerMenuItemItems should contain correct items', () {
      final items = AppMenu.drawerMenuItemItems;

      expect(items, contains(AppMenu.settingsItem));
      expect(items, contains(AppMenu.aboutMenu));
      if (kDebugMode) {
        expect(items, contains(AppMenu.developerShowCaseItemMenu));
      }
    });
  });
}
