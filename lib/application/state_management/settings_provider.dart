import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wallet/application/state_management/shared_preferences_provider.dart';

part 'settings_provider.g.dart';

@riverpod
class ThemeModeSetting extends _$ThemeModeSetting {
  dynamic _prefs;

  @override
  ThemeMode build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    final themeMode = _prefs.getInt('themeMode');
    // switch (themeMode) {
    //   case 1:
    //     return ThemeMode.light;
    //   case 2:
    //     return ThemeMode.dark;
    //   default:
    //     return ThemeMode.system;
    // }
    return switch (themeMode) {
      1 => ThemeMode.light,
      2 => ThemeMode.dark,
      _ => ThemeMode.system
    };
  }

  void changeTheme(ThemeMode themeMode) {
    state = themeMode;
    switch (themeMode) {
      case ThemeMode.light:
        _prefs.setInt('themeMode', 1);
      case ThemeMode.dark:
        _prefs.setInt('themeMode', 2);
      default:
        _prefs.setInt('themeMode', 3);
    }
  }
}
