import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '/business/base_bloc.dart';
import '/data/movie_repository.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends BaseBloc<GetMovieDetailEvent, MovieDetailState> {
  final MovieRepository movieRepository;
  Connectivity connectivity = Connectivity();

  late final StreamSubscription<GetMovieDetailEvent> _eventSubscription;

  MovieDetailBloc(this.movieRepository) : super(MovieDetailInit()) {
    _eventSubscription = eventController.stream.listen((GetMovieDetailEvent event) async {
      final connectResult = await connectivity.checkConnectivity();
      if (!connectResult.contains(ConnectivityResult.none)) {
        try {
          final info = await movieRepository.getMovieInfo(event.movieId);
          state = GetMovieDetailSuccess(info);
        } catch (e) {
          state = GetMovieDetailError(e.toString());
        }
      }

      // Add new state to stateController so UI can receive it
      stateController.sink.add(state);
    });
  }

  void fetchMovieDetail(int movieId) {
    eventController.sink.add(GetMovieDetailEvent(movieId));
  }

  @override
  void dispose() {
    _eventSubscription.cancel();
    eventController.close();
    stateController.close();
    super.dispose();
  }
}
