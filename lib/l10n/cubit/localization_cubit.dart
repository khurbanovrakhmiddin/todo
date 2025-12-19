import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'localization_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit()
    : super(
        const AppSettingsState(
          locale: Locale('ru'),
          themeMode: ThemeMode.system,
        ),
      ) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('locale') ?? 'ru';
    final themeName = prefs.getString('theme') ?? 'system';

    emit(
      AppSettingsState(
        locale: Locale(langCode),
        themeMode: _mapToThemeMode(themeName),
      ),
    );
  }

  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale.languageCode);
    emit(state.copyWith(locale: locale));
  }

  Future<void> setTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', mode.name);
    emit(state.copyWith(themeMode: mode));
  }

  ThemeMode _mapToThemeMode(String name) {
    switch (name) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
