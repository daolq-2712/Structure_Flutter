import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final int? id;
  final String? name;

  const Genre({this.id, this.name});

  factory Genre.parserFromJson(Map<String, dynamic>? result) {
    if (result == null) return const Genre();
    return Genre(id: result['id'], name: result['name']);
  }

  @override
  List<Object> get props => [id ?? 0, name ?? ''];
}
