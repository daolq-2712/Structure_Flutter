import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String? name;
  final String? code;

  const Country({this.name, this.code});

  factory Country.parserFromJson(Map<String, dynamic>? result) {
    if (result == null) return const Country();

    return Country(
      name: result['name'],
      code: result['iso_3166_1'],
    );
  }

  @override
  List<Object> get props => [name ?? '', code ?? ''];
}
