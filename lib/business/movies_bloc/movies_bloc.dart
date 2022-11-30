import 'package:connectivity/connectivity.dart';

import '../../data/movie_type.dart';
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
          stateController.add(state);
          final movies = await movieRepository.fetchMovies(event.type);
          state = FetchMoviesSuccess(movies, event.type);
          stateController.add(state);
        } on Exception catch (e) {
          state = FetchMoviesError(e.toString());
          stateController.add(state);
        }
      }

      if (event is FetchMoreMoviesWithType) {
        try {
          final movies =
              await movieRepository.fetchMovies(event.type, page: event.page);
          state = FetchMoviesSuccess(movies, event.type);
          stateController.add(state);
        } on Exception catch (e) {
          state = FetchMoviesError(e.toString());
          stateController.add(state);
        }
      }

      final connectResult = await connectivity.checkConnectivity();
      if (connectResult == ConnectivityResult.none) {
        state = FetchMoviesError('Please check the network connection');
        stateController.add(state);
      }
    });
  }

  void fetchMoviesByType(MovieType movieType) {
    eventController.sink.add(FetchMoviesWithType(movieType.value));
  }

  void fetchMoreMoviesByType(MovieType movieType, {required int page}) {
    eventController.sink
        .add(FetchMoreMoviesWithType(movieType.value, page: page));
  }
}
