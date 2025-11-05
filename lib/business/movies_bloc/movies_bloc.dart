import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '/business/base_bloc.dart';
import '/data/movie_repository.dart';
import '/data/movie_type.dart';
import 'movies_event.dart';
import 'movies_state.dart';

class MoviesBloc extends BaseBloc<FetchMoviesEvent, FetchMoviesState> {
  final MovieRepository movieRepository;

  final Connectivity _connectivity = Connectivity();

  late final StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  List<ConnectivityResult> _lastConnectivityResult = [ConnectivityResult.none];

  MoviesBloc(this.movieRepository) : super(FetchMoviesStateInitialized()) {

    // Initialize connectivity status
    _connectivity.checkConnectivity().then((result) {
      _lastConnectivityResult = result;
    });

    // Listen to connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
       _lastConnectivityResult = result;
    });

    eventController.stream.listen((FetchMoviesEvent event) async {
      if (_lastConnectivityResult.contains(ConnectivityResult.none)) {
        state = FetchMoviesError('Please check the network connection');
        stateController.add(state);
        return;
      }

      if (event is FetchMoviesWithType) {
        try {
          state = FetchMoviesStateLoading();
          stateController.add(state);
          final movies = await movieRepository.fetchMovies(event.type.value);
          state = FetchMoviesSuccess(movies, event.type.value);
          stateController.add(state);
        } on Exception catch (e) {
          state = FetchMoviesError(e.toString());
          stateController.add(state);
        }
      } else if (event is FetchMoreMoviesWithType) {
        try {
          final movies =
              await movieRepository.fetchMovies(event.type.value, page: event.page);
          state = FetchMoviesSuccess(movies, event.type.value);
          stateController.add(state);
        } on Exception catch (e) {
          state = FetchMoviesError(e.toString());
          stateController.add(state);
        }
      }
    });
  }  

  void fetchMoviesByType(MovieType movieType) {
    eventController.sink.add(FetchMoviesWithType(movieType));
  }

  void fetchMoreMoviesByType(MovieType movieType, {required int page}) {
    eventController.sink
        .add(FetchMoreMoviesWithType(movieType, page: page));
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
