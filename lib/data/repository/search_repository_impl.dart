import '/data/local/shared_pref_api.dart';
import '/data/local/shared_pref_impl.dart';
import '/data/local/shared_pref_key.dart';

import '../search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  static SearchRepositoryImpl? _instance;

  final SharedPrefApi _sharedPrefApi;

  SearchRepositoryImpl._(SharedPrefApi sharedPrefApi)
      : _sharedPrefApi = sharedPrefApi;

  static Future<SearchRepositoryImpl> getInstance() async {
    if (_instance == null) {
      final sharedPrefApi = await SharedPrefImpl.getInstance();
      _instance = SearchRepositoryImpl._(sharedPrefApi);
    }
    return _instance!;
  }

  @override
  Future<List<String>> getSearchHistory() {
    return _sharedPrefApi.get(SharedPrefKey.previousSearches);
  }

  @override
  void saveSearchHistory(List<String> searches) {
    _sharedPrefApi.put(SharedPrefKey.previousSearches, searches);
  }
}
