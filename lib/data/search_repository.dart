abstract class SearchRepository {
  void saveSearchHistory(List<String> searches);

  Future<List<String>> getSearchHistory();
}
