import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  initialize() async {
    await _prefs;
  }

  static save(String key,String value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(key, value);
  }

  static Future<String> read(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key)??'';
  }

}