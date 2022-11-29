import 'package:equatable/equatable.dart';

abstract class FetchMoviesEvent extends Equatable {}

class FetchMoviesWithType extends FetchMoviesEvent {
  final String type;

  FetchMoviesWithType(this.type);

  @override
  List<Object> get props => [type];
}
