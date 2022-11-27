
import 'model/movie.dart';
import 'model/movie_image.dart';
import 'model/movie_info.dart';

abstract class MovieRepository {
  Future<List<Movie>> fetchMovies(String type);

  Future<MovieInfo> getMovieInfo(int movieId);

  Future<MovieImage> getMovieImages(int movieId);
}
