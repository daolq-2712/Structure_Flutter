import 'package:equatable/equatable.dart';

abstract class FetchMoviesEvent extends Equatable {}

class FetchMoviesWithType extends FetchMoviesEvent {
  final String type;

  FetchMoviesWithType(this.type);

  @override
  List<Object> get props => [type];
}

class FetchMoreMoviesWithType extends FetchMoviesEvent {
  final String type;
  final int page;

  FetchMoreMoviesWithType(this.type, {this.page = 1});

  @override
  List<Object> get props => [type, page];
}
