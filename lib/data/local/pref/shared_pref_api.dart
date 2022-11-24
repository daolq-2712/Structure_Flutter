abstract class SharedPrefApi {
  T? get<T>(String key);

  void put<T>(String key, T? value);

  void clearKey(String key);

  void clear();
}
