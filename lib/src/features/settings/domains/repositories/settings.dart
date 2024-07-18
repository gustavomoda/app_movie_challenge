import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/externals/storage/app_storage.dart';

@LazySingleton()
class AppSettingsRepository {
  AppSettingsRepository(this._storage);

  final AppStorage _storage;

  final _themeModeKey = 'settings-theme';
  final _languageKey = 'settings-language';

  Future<void> saveThemeMode(Brightness brightness) async {
    await _storage.write(key: _themeModeKey, value: brightness.toString());
  }

  Future<Brightness> getThemeMode() async {
    final value = await _storage.read(key: _themeModeKey);
    return value == 'Brightness.dark' ? Brightness.dark : Brightness.light;
  }

  Future<void> saveLanguage(String locale) async {
    await _storage.write(key: _languageKey, value: locale);
  }

  Future<String?> getLanguage() async {
    final value = await _storage.read(key: _languageKey);
    return value;
  }
}
