import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Preference Variables
const String _storageKey = "MyApp_";
const List<String> _supportedLanguages = ['en', 'cn'];
const List<String> _supportedLanguagesName = [
  'english',
  'chinese'
];
Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class GlobalTranslations {
  Locale _locale;
  Map<dynamic, dynamic> _localizedValues;
  VoidCallback _onLocaleChangedCallback;

  final List<String> supportedLanguagesName = _supportedLanguagesName;
  final List<String> supportedLanguagesCodes = _supportedLanguages;

  GlobalTranslations._internal();

  /// Returns the list of supported locales
  Iterable<Locale> supportedLocales() =>
      _supportedLanguages.map<Locale>((lang) => new Locale(lang, ''));

  /// Returns the translation that corresponds to the [key]
  String text(String key) {
    // Return string
    return (_localizedValues == null || _localizedValues[key] == null)
        ? "$key not found!"
        : _localizedValues[key];
  }

  /// Returns current language code
  get currentLanguage => _locale == null ? '' : _locale.languageCode;

  /// Return current locale selected
  get locale => _locale;

  /// init language
  Future<Null> init([String language]) async {
    if (_locale == null) {
      await setNewLanguage(language);
    }
    return language;
  }

  Future<Null> setNewLanguage([String language, bool saveInPrefs = false]) async {
    if (language == null) {
      language = await getPreferredLanguage();
    }

    if (language == "") {
      language = "en"; // change to default if still empty
    }

    _locale = Locale(language, '');

    // Load the language strings
    String jsonContent = await rootBundle
        .loadString('assets/locale/localization_${_locale.languageCode}.json');
    _localizedValues = json.decode(jsonContent);

    // if save preference is needed
    if (saveInPrefs) {
      await setPreferredLanguage(language);
    }

    // invoke callback if there is a callback, tell language has changed
    if (_onLocaleChangedCallback != null) {
      _onLocaleChangedCallback();
    }

    return null;
  }

  set onLocaleChangedCallback(VoidCallback callback) {
    _onLocaleChangedCallback = callback;
  }

  getPreferredLanguage() async {
    return _getApplicationSavedInformation('language');
  }

  /// Fetch preference data
  Future<String> _getApplicationSavedInformation(String name) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(_storageKey + name) ?? "";
  }

  setPreferredLanguage(String language) async {
    return _setApplicationSavedInformation('language', language);
  }

  /// save apllication preference data
  Future<bool> _setApplicationSavedInformation(
      String name, String value) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(_storageKey + name, value);
  }

  /// singleton factory
  static final GlobalTranslations _translations =
      new GlobalTranslations._internal();
  factory GlobalTranslations() {
    return _translations;
  }
}

GlobalTranslations allTranslations = new GlobalTranslations();
