// Add to pubspec.yaml:
// dependencies:
//   shared_preferences: ^2.2.2

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsKey {
  String token = "token";
}

class SharedPrefsService {
  static SharedPreferences? _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // String operations
  Future<bool> setString(String key, String value) async {
    return await _prefs?.setString(key, value) ?? false;
  }

  String getString(String key, {String defaultValue = ''}) {
    return _prefs?.getString(key) ?? defaultValue;
  }

  // Int operations
  Future<bool> setInt(String key, int value) async {
    return await _prefs?.setInt(key, value) ?? false;
  }

  int getInt(String key, {int defaultValue = 0}) {
    return _prefs?.getInt(key) ?? defaultValue;
  }

  // Double operations
  Future<bool> setDouble(String key, double value) async {
    return await _prefs?.setDouble(key, value) ?? false;
  }

  double getDouble(String key, {double defaultValue = 0.0}) {
    return _prefs?.getDouble(key) ?? defaultValue;
  }

  // Bool operations
  Future<bool> setBool(String key, bool value) async {
    return await _prefs?.setBool(key, value) ?? false;
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs?.getBool(key) ?? defaultValue;
  }

  // List<String> operations
  Future<bool> setStringList(String key, List<String> value) async {
    return await _prefs?.setStringList(key, value) ?? false;
  }

  List<String> getStringList(String key,
      {List<String> defaultValue = const []}) {
    return _prefs?.getStringList(key) ?? defaultValue;
  }

  // Object operations (converts to/from JSON)
  Future<bool> setObject(String key, Map<String, dynamic> value) async {
    return await _prefs?.setString(key, jsonEncode(value)) ?? false;
  }

  Map<String, dynamic> getObject(String key) {
    String? jsonString = _prefs?.getString(key);
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return {};
  }

  // Remove a specific key
  Future<bool> remove(String key) async {
    return await _prefs?.remove(key) ?? false;
  }

  // Clear all data
  Future<bool> clear() async {
    return await _prefs?.clear() ?? false;
  }

  // Check if key exists
  bool containsKey(String key) {
    return _prefs?.containsKey(key) ?? false;
  }
}

// Constants for keys (to avoid typos)
class SharedPrefsKeys {
  static const String userId = 'user_id';
  static const String userToken = 'user_token';
  static const String isDarkMode = 'is_dark_mode';
  static const String language = 'language';
  static const String userSettings = 'user_settings';
  // Add more keys as needed
}

// Example usage
class SharedPrefsExample {
  final SharedPrefsService _prefs = SharedPrefsService();

  Future<void> exampleUsage() async {
    // Initialize in main.dart or app startup
    await SharedPrefsService.init();

    // Store values
    await _prefs.setString(SharedPrefsKeys.userId, '12345');
    await _prefs.setBool(SharedPrefsKeys.isDarkMode, true);
    await _prefs.setStringList('recent_searches', ['flutter', 'dart']);

    // Store object
    await _prefs.setObject(SharedPrefsKeys.userSettings,
        {'notifications': true, 'fontSize': 14, 'theme': 'dark'});

    // Retrieve values
    String userId = _prefs.getString(SharedPrefsKeys.userId);
    bool isDarkMode = _prefs.getBool(SharedPrefsKeys.isDarkMode);
    List<String> recentSearches = _prefs.getStringList('recent_searches');
    Map<String, dynamic> settings =
        _prefs.getObject(SharedPrefsKeys.userSettings);

    // Remove specific data
    await _prefs.remove(SharedPrefsKeys.userId);

    // Clear all data
    await _prefs.clear();
  }
}
