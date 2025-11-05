abstract class SharedPrefApi {
  T? get<T>(String key);

  void put<T>(String key, T? value);

  Future<void> clearKey(String key);

  Future<void> clear();
}
