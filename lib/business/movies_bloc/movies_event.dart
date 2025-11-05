import 'package:equatable/equatable.dart';

import '/data/movie_type.dart';

abstract class FetchMoviesEvent extends Equatable {}

class FetchMoviesWithType extends FetchMoviesEvent {
  final MovieType type;

  FetchMoviesWithType(this.type);

  @override
  List<Object> get props => [type];
}

class FetchMoreMoviesWithType extends FetchMoviesEvent {
  final MovieType type;
  final int page;

  FetchMoreMoviesWithType(this.type, {this.page = 1});

  @override
  List<Object> get props => [type, page];
}
