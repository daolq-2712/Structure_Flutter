import 'package:equatable/equatable.dart';

class Img extends Equatable {
  final double aspect;
  final String imagePath;
  final int height;
  final int width;
  final String countryCode;
  final double voteAverage;
  final int voteCount;

  const Img({
    required this.aspect,
    required this.imagePath,
    required this.height,
    required this.width,
    required this.countryCode,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Img.parserFromJson(Map<String, dynamic> result) {
    return Img(
      imagePath: result['file_path'],
      aspect: double.tryParse(result['aspect_ratio'].toString()) ?? 1.0,
      height: result['height'] ?? 0,
      width: result['width'] ?? 1,
      countryCode: result['iso_639_1'],
      voteAverage: result['vote_average'],
      voteCount: result['vote_count'],
    );
  }

  @override
  List<Object> get props => [
        aspect,
        imagePath,
        width,
        height,
        countryCode,
        voteCount,
        voteAverage,
        voteCount
      ];
}
