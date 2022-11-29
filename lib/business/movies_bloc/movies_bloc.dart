import 'package:connectivity/connectivity.dart';

import '../../data/constant/constant.dart';
import '../../data/movie_repository.dart';
import '../base_bloc.dart';
import 'movies_event.dart';
import 'movies_state.dart';

class MoviesBloc extends BaseBloc<FetchMoviesEvent, FetchMoviesState> {
  final MovieRepository movieRepository;

  final Connectivity connectivity = Connectivity();

  MoviesBloc(this.movieRepository) : super(FetchMoviesStateInitialized()) {
    eventController.stream.listen((FetchMoviesEvent event) async {

      if (event is FetchMoviesWithType) {
        try {
          state = FetchMoviesStateLoading();
          final movies = await movieRepository.fetchMovies(event.type);
          state = FetchMoviesSuccess(movies, event.type);
        } on Exception catch (e) {
          state = FetchMoviesError(e.toString());
        }
      }

      final connectResult = await connectivity.checkConnectivity();
      if (connectResult == ConnectivityResult.none) {
        state = FetchMoviesError('Please check the network connection');
      }

      // add state mới vào stateController để bên UI nhận được
      stateController.sink.add(state);
    });
  }

  void fetchMovieNowPlaying() {
    eventController.sink.add(FetchMoviesWithType(Constant.nowPlaying));
  }

  void fetchMovieUpComing() {
    eventController.sink.add(FetchMoviesWithType(Constant.upcoming));
  }

  void fetchMovieTopRate() {
    eventController.sink.add(FetchMoviesWithType(Constant.topRated));
  }

  void fetchMoviePopular() {
    eventController.sink.add(FetchMoviesWithType(Constant.popular));
  }
}