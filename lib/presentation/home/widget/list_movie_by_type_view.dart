import 'package:flutter/material.dart';

import '/business/movies_bloc/movies_bloc.dart';
import '/data/movie_type.dart';
import '/data/repository/movie_repository_impl.dart';

class ListMovieByTypeView extends StatefulWidget {
  final MovieType movieType;

  const ListMovieByTypeView({Key? key, required this.movieType})
      : super(key: key);

  @override
  State<ListMovieByTypeView> createState() => _ListMovieByTypeViewState();
}

class _ListMovieByTypeViewState extends State<ListMovieByTypeView> {
  late MoviesBloc _moviesBloc;

  @override
  void initState() {
    super.initState();
    _moviesBloc = MoviesBloc(MovieRepositoryImpl());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _moviesBloc.fetchMoviesByType(widget.movieType);
    });
  }

  @override
  void dispose() {
    _moviesBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
