import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '/data/model/movie.dart';
import '/data/movie_type.dart';
import '/data/repository/movie_repository_impl.dart';
import '/business/movies_bloc/movies_state.dart';
import '/business/movies_bloc/movies_bloc.dart';
import '/presentation/widget/error_page.dart';
import '/utils/theme/colors.dart';
import '/utils/constant.dart';

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
    return StreamBuilder<FetchMoviesState>(
      stream: _moviesBloc.stateController.stream,
      initialData: FetchMoviesStateInitialized(),
      builder: (context, snapshot) {
        var state = snapshot.data;
        if (state is FetchMoviesStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FetchMoviesSuccess) {
          return _createListMovie(context, state.movies);
        } else if (state is FetchMoviesError) {
          return ErrorPage(
              message: state.message,
              retry: () {
                _moviesBloc.fetchMoviesByType(widget.movieType);
              });
        } else {
          return Container();
        }
      },
    );
  }

  Widget _createListMovie(BuildContext context, List<Movie> movies) {
    final contentHeight = 4.0 * (MediaQuery.of(context).size.width / 2.4) / 3;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  widget.movieType.getLabel(context),
                  style: const TextStyle(
                      color: groupTitleColor,
                      fontSize: 16,
                      fontFamily: 'HelveticaNeue',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward, color: groupTitleColor),
              onPressed: () {},
            )
          ],
        ),
        SizedBox(
          height: contentHeight,
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              Movie movie = movies[index];
              return _createMyListItem(context, movie);
            },
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const VerticalDivider(
              color: Colors.transparent,
              width: 6.0,
            ),
            itemCount: movies.length,
          ),
        ),
      ],
    );
  }

  Widget _createMyListItem(BuildContext context, Movie movie) {
    final width = MediaQuery.of(context).size.width / 2.6;
    return Container(
      width: width,
      height: double.infinity,
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Card(
        elevation: 10.0,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SizedBox(
          width: width,
          height: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              imageUrl: '${Constant.prefixImageUrl}${movie.posterPath}',
              width: width,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
