import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  static const _themeKey = 'isDarkMode';
  static const _historyKey = 'calculator_history';

  bool get isDarkMode => _prefs.getBool(_themeKey) ?? true;

  Future<void> saveThemeMode(bool isDark) async {
    await _prefs.setBool(_themeKey, isDark);
  }

  List<String> getHistory() {
    final jsonString = _prefs.getString(_historyKey);
    if (jsonString != null) {
      return List<String>.from(jsonDecode(jsonString));
    }
    return [];
  }

  Future<void> saveHistory(List<String> history) async {
    final jsonString = jsonEncode(history);
    await _prefs.setString(_historyKey, jsonString);
  }
}
