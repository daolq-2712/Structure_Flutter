import 'package:equatable/equatable.dart';

import '../../data/model/movie.dart';

abstract class FetchMoviesState extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMoviesStateInitialized extends FetchMoviesState {
  @override
  String toString() {
    return 'MovieStateInitialized';
  }
}

class FetchMoviesStateLoading extends FetchMoviesState {
  @override
  String toString() {
    return 'FetchMoviesStateLoading';
  }
}

class FetchMoviesSuccess extends FetchMoviesState {
  final List<Movie> movies;
  final String type;

  FetchMoviesSuccess(this.movies, this.type);

  @override
  List<Object> get props => [movies, type];

  @override
  String toString() {
    return 'FetchMoviesSuccess';
  }
}

class FetchMoviesError extends FetchMoviesState {
  final String message;

  FetchMoviesError(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    return 'FetchMoviesError';
  }
}
