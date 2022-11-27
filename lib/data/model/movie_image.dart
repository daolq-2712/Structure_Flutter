import 'package:equatable/equatable.dart';

import 'image.dart';

class MovieImage extends Equatable {
  final List<Img>? backdrops;
  final List<Img>? posters;

  const MovieImage({this.backdrops, this.posters});

  factory MovieImage.parserFromJson(Map<String, dynamic> result) {
    return MovieImage(
      backdrops: (result['backdrops'] as List)
          .map((e) => Img.parserFromJson(e))
          .toList(),
      posters: (result['posters'] as List)
          .map((e) => Img.parserFromJson(e))
          .toList(),
    );
  }

  @override
  List<Object> get props => [backdrops ?? [], posters ?? []];
}
