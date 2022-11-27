import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../bussiness/movie_bloc/movie_state.dart';
import '../../../data/model/movie.dart';

class CategoryView extends StatefulWidget {
  final Function(Movie) actionOpenCategory;

  CategoryView({Key key, @required this.actionOpenCategory}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  MovieBloc _movieBloc;

  @override
  void initState() {
    super.initState();
    _movieBloc = MovieBloc(MovieRepositoryImpl());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _movieBloc.fetchMovieUpComing();
    });
  }

  @override
  void dispose() {
    _movieBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieState>(
      stream: _movieBloc.stateController.stream,
      initialData: _movieBloc.state,
      builder: (BuildContext context, AsyncSnapshot<MovieState> snapshot) {
        var state = snapshot.data;
        if (state is MovieStateInit) {
          return const Center(child: const CircularProgressIndicator());
        } else if (state is MovieFetchError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              _movieBloc.fetchMovieUpComing();
            },
          );
        } else if (state is MovieFetched) {
          return _createCategoryList(context, state.movies);
        } else {
          return Text(AppLocalizations.of(context).cannotSupport);
        }
      },
    );
  }

  Widget _createCategoryList(BuildContext context, List<Movie> movies) {
    return Container(
      width: double.infinity,
      height: 96.0,
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _createCategoryItem(context, movies[index]);
        },
        itemCount: movies.length,
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => VerticalDivider(
          color: Colors.transparent,
          width: 6.0,
        ),
      ),
    );
  }

  Widget _createCategoryItem(BuildContext context, Movie movie) {
    final width = MediaQuery.of(context).size.width / 2.5;

    return InkWell(
      onTap: () {
        widget.actionOpenCategory(movie);
      },
      child: Container(
        width: width,
        height: double.infinity,
        padding: EdgeInsets.only(bottom: 12.0),
        child: Card(
          elevation: 8.0,
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            width: width,
            height: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                    width: width,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: width,
                    height: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0.1, 0.5, 0.7, 0.9],
                        colors: [
                          Color(0x99ff0000),
                          Color(0x66ff0000),
                          Color(0x66ff0000),
                          Color(0x99ff0000),
                        ],
                      ),
                    ),
                    child: Text(
                      movie.releaseDate ?? '',
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        fontFamily: 'Muli',
                        color: white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
