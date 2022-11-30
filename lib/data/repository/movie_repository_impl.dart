import '../model/movie.dart';
import '../model/movie_image.dart';
import '../model/movie_info.dart';
import '../movie_repository.dart';
import '../remote/movie_service_client.dart';
import '../remote/response/movie_response.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieServiceClient _client;

  MovieRepositoryImpl({MovieServiceClient? client})
      : _client = client ?? MovieServiceClient.instance;

  @override
  Future<List<Movie>> fetchMovies(String type, {int page = 1}) async {
    final json = await _client.getJsonFromUrl(
        '${MovieServiceClient.apiUrl}$type?api_key=${MovieServiceClient.apiKey}&page=$page');
    return MovieResponse.parserFromJson(json).movies ?? List.empty();
  }

  @override
  Future<MovieInfo> getMovieInfo(int movieId) async {
    final json = await _client.getJsonFromUrl(
        '${MovieServiceClient.apiUrl}$movieId?api_key=${MovieServiceClient.apiKey}');
    return MovieInfo.parserFromJson(json);
  }

  @override
  Future<MovieImage> getMovieImages(int movieId) async {
    final json = await _client.getJsonFromUrl(
        '${MovieServiceClient.apiUrl}$movieId/images?api_key=${MovieServiceClient.apiKey}');
    return MovieImage.parserFromJson(json);
  }
}
