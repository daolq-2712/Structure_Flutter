import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '/business/movies_bloc/movies_bloc.dart';
import '/data/model/movie.dart';
import '/data/movie_type.dart';
import '/data/repository/movie_repository_impl.dart';
import '/business/movies_bloc/movies_state.dart';
import '/utils/constant.dart';
import '../widget/error_page.dart';

class ListMoviePage extends StatefulWidget {
  final MovieType movieType;

  const ListMoviePage({Key? key, required this.movieType}) : super(key: key);

  @override
  State<ListMoviePage> createState() => _ListMoviePageState();
}

class _ListMoviePageState extends State<ListMoviePage> {
  late MoviesBloc _moviesBloc;

  int page = 1;

  bool _hasNextPage = false;
  bool _isLoadMoreRunning = false;
  List<Movie> movies = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _moviesBloc = MoviesBloc(MovieRepositoryImpl());
    // Handle load more
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_hasNextPage && !_isLoadMoreRunning) {
          page++;
          _isLoadMoreRunning = true;
          _moviesBloc.fetchMoreMoviesByType(widget.movieType, page: page);
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // First load data
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
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 4.0,
        backgroundColor: Colors.red,
        title: Text(widget.movieType.getLabel(context)),
      ),
      body: StreamBuilder<FetchMoviesState>(
        stream: _moviesBloc.stateController.stream,
        initialData: FetchMoviesStateInitialized(),
        builder: (context, snapshot) {
          var state = snapshot.data;
          // Show loading first load
          if (state is FetchMoviesStateLoading && !_isLoadMoreRunning) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FetchMoviesSuccess) {
            if (state.movies.isNotEmpty) {
              _hasNextPage = true;
              movies.addAll(state.movies);
            } else {
              _hasNextPage = false;
            }
            _isLoadMoreRunning = false;
            return _createListMovie(context, movies);
          } else if (state is FetchMoviesError) {
            return ErrorPage(
                message: state.message,
                retry: () {
                  _refreshData();
                });
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _createListMovie(BuildContext context, List<Movie> movies) {
    return RefreshIndicator(
      onRefresh: () async {
        // Pull to refresh
        _refreshData();
      },
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          Movie movie = movies[index];
          return _createListItem(context, movie);
        },
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        scrollDirection: Axis.vertical,
        separatorBuilder: (context, index) => const VerticalDivider(
          color: Colors.transparent,
          width: 6.0,
        ),
        itemCount: movies.length,
        controller: _scrollController,
      ),
    );
  }

  Widget _createListItem(BuildContext context, Movie movie) {
    final heightOfRow = MediaQuery.of(context).size.width / 2.5;
    return Container(
      height: heightOfRow,
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Card(
        elevation: 10.0,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SizedBox(
          height: heightOfRow,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Stack(children: [
              CachedNetworkImage(
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                imageUrl: '${Constant.prefixImageUrl}${movie.posterPath}',
                height: heightOfRow,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 4,
                right: 8,
                child: Text(
                  movie.originalTitle ?? '',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'HelveticaNeue',
                      fontWeight: FontWeight.bold),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  void _refreshData() {
    movies.clear();
    page = 1;
    _hasNextPage = false;
    _isLoadMoreRunning = false;
    _moviesBloc.fetchMoviesByType(widget.movieType);
  }
}
