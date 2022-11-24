import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/generic_helper.dart';
import 'shared_pref_api.dart';

class SharedPrefImpl implements SharedPrefApi {
  static SharedPrefImpl? _instance;

  final SharedPreferences? _sharedPreferences;

  static Future<SharedPrefImpl> getInstance() async {
    if (_instance == null) {
      final sharedPreferences = await SharedPreferences.getInstance();
      _instance = SharedPrefImpl._(sharedPreferences);
    }
    return _instance!;
  }

  SharedPrefImpl._(SharedPreferences sharedPreferences)
      : _sharedPreferences = sharedPreferences;

  @override
  T? get<T>(String key) {
    if (_sharedPreferences == null) return null;
    if (typeOf<String>() == T) {
      return _sharedPreferences?.getString(key) as T?;
    } else if (typeOf<int>() == T) {
      return _sharedPreferences?.getInt(key) as T?;
    } else if (typeOf<double>() == T) {
      return _sharedPreferences?.getDouble(key) as T?;
    } else if (typeOf<bool>() == T) {
      return _sharedPreferences?.getBool(key) as T?;
    } else if (typeOf<List<String>>() == T) {
      return _sharedPreferences?.getStringList(key) as T?;
    } else {
      return _sharedPreferences?.get(key) as T?;
    }
  }

  @override
  void put<T>(String key, T? value) {
    if (typeOf<String>() == T) {
      _sharedPreferences?.setString(key, value as String);
    } else if (typeOf<int>() == T) {
      _sharedPreferences?.setInt(key, value as int);
    } else if (typeOf<double>() == T) {
      _sharedPreferences?.setDouble(key, value as double);
    } else if (typeOf<bool>() == T) {
      _sharedPreferences?.setBool(key, value as bool);
    } else if (typeOf<List<String>>() == T) {
      _sharedPreferences?.setStringList(key, value as List<String>);
    } else {
      throw const FormatException("Invalid format type");
    }
  }

  @override
  void clearKey(String key) async {
    await _sharedPreferences?.remove(key);
  }

  @override
  void clear() async {
    await _sharedPreferences?.clear();
  }
}
