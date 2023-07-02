import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesRepository {
  Future<void> saveLocale(Locale? locale);
  Future<Locale?> get locale;
  Future<void> saveThemeMode(ThemeMode? themeMode);
  Future<ThemeMode> get themeMode;
  Future<ThemeMode> get themeModeFirstTime;
}

class PreferencesRepositoryImpl implements PreferencesRepository {
  static const String _localeLanguageCodeKey = 'localeLanguageCode';
  static const String _localeScriptCodeKey = 'localeScriptCode';
  static const String _localeCountryCodeKey = 'localeCountryCode';

  @override
  Future<Locale?> get locale async {
    final prefs = await SharedPreferences.getInstance();

    final String languageCode = prefs.getString(_localeLanguageCodeKey) ?? "";
    final String scriptCode = prefs.getString(_localeScriptCodeKey) ?? "";
    final String countryCode = prefs.getString(_localeCountryCodeKey) ?? "";

    if (languageCode.isNotEmpty && languageCode.isNotEmpty) {
      return Locale.fromSubtags(
        languageCode: languageCode,
        scriptCode: scriptCode.isEmpty ? null : scriptCode,
        countryCode: countryCode.isEmpty ? null : countryCode,
      );
    }
    return null;
  }

  @override
  Future<void> saveLocale(Locale? locale) async {
    final prefs = await SharedPreferences.getInstance();
    Get.updateLocale(locale ?? const Locale("und"));
    if (locale != null) {
      await prefs.setString(_localeLanguageCodeKey, locale.languageCode);
      await prefs.setString(_localeScriptCodeKey, locale.scriptCode ?? '');
      await prefs.setString(_localeCountryCodeKey, locale.countryCode ?? '');
    } else {
      await prefs.remove(_localeLanguageCodeKey);
      await prefs.remove(_localeScriptCodeKey);
      await prefs.remove(_localeCountryCodeKey);
    }
  }

  @override
  Future<ThemeMode> get themeMode async {
    ThemeMode themeMode;
    final prefs = await SharedPreferences.getInstance();
    String themeText = prefs.getString('theme') ?? 'system';
    try {
      themeMode = ThemeMode.values.firstWhere((e) => describeEnum(e) == themeText);
    } catch (e) {
      themeMode = ThemeMode.system;
    }
    return themeMode;
  }

  @override
  Future<ThemeMode> get themeModeFirstTime async {
    ThemeMode themeMode;
    final prefs = await SharedPreferences.getInstance();
    String themeText = prefs.getString('theme') ?? 'system';
    try {
      themeMode = ThemeMode.values.firstWhere((e) => describeEnum(e) == themeText);
    } catch (e) {
      themeMode = ThemeMode.system;
    }
    saveThemeMode(themeMode);
    return themeMode;
  }

  @override
  Future<void> saveThemeMode(ThemeMode? themeMode) async {
    // To change the theme using the Preferences bloc (state)
    Get.changeThemeMode(themeMode ?? ThemeMode.system);

    final prefs = await SharedPreferences.getInstance();

    if (themeMode != null) {
      await prefs.setString('theme', themeMode.toString().split('.')[1]);
    } else {
      await prefs.remove('theme');
    }
  }
}
