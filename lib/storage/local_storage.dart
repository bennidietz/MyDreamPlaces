import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences _sharedPreferences;

  static LocalStorage _singleton = new LocalStorage._internal();

  factory LocalStorage() => _singleton;

  LocalStorage._internal() {
    initializeSharedPreferences();
  }

  static Future<void> initializeSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setItem(String key, String value)
    => _sharedPreferences.setString(key, value);

  static String? getItem(String key) {
    return _sharedPreferences.getString(key);
  }
}