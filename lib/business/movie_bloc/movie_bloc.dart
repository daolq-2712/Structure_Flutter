import 'package:connectivity/connectivity.dart';

import '../../data/constant/constant.dart';
import '../../data/movie_repository.dart';
import '../base_bloc.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends BaseBloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  final Connectivity connectivity = Connectivity();

  MovieBloc(this.movieRepository) : super(MovieStateInit()) {
    eventController.stream.listen((MovieEvent event) async {

      if (event is FetchMovieWithType) {
        try {
          final movies = await movieRepository.fetchMovies(event.type);
          state = MovieFetched(movies, event.type);
        } on Exception catch (e) {
          state = MovieFetchError(e.toString());
        }
      }

      final connectResult = await connectivity.checkConnectivity();
      if (connectResult == ConnectivityResult.none) {
        state = MovieFetchError('Please check the network connection');
      }

      // add state mới vào stateController để bên UI nhận được
      stateController.sink.add(state);
    });
  }

  void fetchMovieNowPlaying() {
    eventController.sink.add(FetchMovieWithType(Constant.nowPlaying));
  }

  void fetchMovieUpComing() {
    eventController.sink.add(FetchMovieWithType(Constant.upcoming));
  }

  void fetchMovieTopRate() {
    eventController.sink.add(FetchMovieWithType(Constant.topRated));
  }

  void fetchMoviePopular() {
    eventController.sink.add(FetchMovieWithType(Constant.popular));
  }
}
