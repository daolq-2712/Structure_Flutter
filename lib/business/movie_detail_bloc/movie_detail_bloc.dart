import 'package:connectivity/connectivity.dart';

import '/data/movie_repository.dart';
import '../base_bloc.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends BaseBloc<GetMovieDetailEvent, MovieDetailState> {
  final MovieRepository movieRepository;
  Connectivity connectivity = Connectivity();

  MovieDetailBloc(this.movieRepository) : super(MovieDetailInit()) {
    eventController.stream.listen((GetMovieDetailEvent event) async {
      try {
        final info = await movieRepository.getMovieInfo(event.movieId);
        state = GetMovieDetailSuccess(info);
      } on Exception catch (e) {
        state = GetMovieDetailError(e.toString());
      }

      final connectResult = await connectivity.checkConnectivity();
      if (connectResult == ConnectivityResult.none) {
        state = GetMovieDetailError('Please check the network connection');
      }

      // add state mới vào stateController để bên UI nhận được
      stateController.sink.add(state);
    });
  }

  void fetchMovieDetail(int movieId) {
    eventController.sink.add(GetMovieDetailEvent(movieId));
  }
}
