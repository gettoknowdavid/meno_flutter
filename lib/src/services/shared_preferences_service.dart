import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_service.g.dart';

@riverpod
SharedPreferencesService sharedPrefs(Ref ref) => throw UnimplementedError();

class SharedPreferencesService {
  static late SharedPreferencesService _instance;
  static late SharedPreferences _pref;

  Future<bool> delete(String key) => _pref.remove(key);

  Future<bool> clear() => _pref.clear();

  bool hasKey(String key) => _pref.containsKey(key);

  dynamic read(String key) => _pref.get(key);

  Future<bool> write(String key, {required dynamic value}) {
    if (value is bool) {
      return _pref.setBool(key, value);
    } else if (value is String) {
      return _pref.setString(key, value);
    } else if (value is int) {
      return _pref.setInt(key, value);
    } else if (value is double) {
      return _pref.setDouble(key, value);
    } else {
      throw Exception('Unknown type');
    }
  }

  static Future<SharedPreferencesService> getInstance() async {
    // Initialise the asynchronous shared preferences
    _pref = await SharedPreferences.getInstance();
    _instance = SharedPreferencesService();

    return Future.value(_instance);
  }
}
