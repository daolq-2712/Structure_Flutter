import 'package:equatable/equatable.dart';

import '../../model/movie.dart';

class MovieResponse extends Equatable {
  final int? page;
  final List<Movie>? movies;
  final int? totalPages;
  final int? totalResult;

  const MovieResponse(
      {this.page, this.movies, this.totalPages, this.totalResult});

  factory MovieResponse.parserFromJson(Map<String, dynamic>? result) {
    if (result == null) return const MovieResponse();
    return MovieResponse(
      page: result['page'],
      movies: (result['results'] as List?)
          ?.map((e) => Movie.parserFromJson(e))
          .toList(),
      totalPages: result['total_pages'],
      totalResult: result['total_results'],
    );
  }

  @override
  List<Object> get props => [
        page ?? 0,
        movies ?? [],
        totalPages ?? 0,
        totalResult ?? 0,
      ];
}
