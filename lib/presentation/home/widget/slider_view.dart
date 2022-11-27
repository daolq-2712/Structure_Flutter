import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_base/src/bloc/movie_bloc/movie_state.dart';
import 'package:flutter_bloc_base/src/models/models.dart';
import 'package:flutter_bloc_base/src/ui/theme/colors.dart';
import 'package:flutter_bloc_base/src/ui/widget/error_page.dart';

import '../../../bloc/movie_bloc/movie_bloc.dart';
import '../../../data/repository/movie_repository_impl.dart';

class SliderView extends StatefulWidget {
  final Function(Movie) actionOpenMovie;

  SliderView({Key key, @required this.actionOpenMovie}) : super(key: key);

  @override
  State<SliderView> createState() => _SliderViewState();
}

class _SliderViewState extends State<SliderView> {
  MovieBloc movieBloc;

  @override
  void initState() {
    super.initState();
    movieBloc = MovieBloc(MovieRepositoryImpl());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      movieBloc.fetchMovieNowPlaying();
    });
  }

  @override
  void dispose() {
    movieBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieState>(
      stream: movieBloc.stateController.stream,
      initialData: MovieStateInit(),
      builder: (BuildContext context, AsyncSnapshot<MovieState> snapshot) {
        var state = snapshot.data;
        if (state is MovieStateInit) {
          return Center(child: const CircularProgressIndicator());
        } else if (state is MovieFetchError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              movieBloc.fetchMovieNowPlaying();
            },
          );
        } else if (state is MovieFetched) {
          final movies = state.movies;
          return CarouselSlider.builder(
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) {
              return _createSliderItem(context, movies[index]);
            },
            options: CarouselOptions(
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              pauseAutoPlayOnTouch: true,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
            ),
          );
        } else {
          return Spacer();
        }
      },
    );
  }

  Widget _createSliderItem(BuildContext context, Movie movie) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        widget.actionOpenMovie(movie);
      },
      child: Container(
        width: width,
        height: double.infinity,
        padding: EdgeInsets.only(bottom: 20.0),
        child: Card(
          elevation: 10.0,
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
                    padding: EdgeInsets.only(left: 16.0, bottom: 20.0),
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0.1, 0.5, 0.7, 0.9],
                        colors: [
                          Color(0x00000000),
                          Color(0x00000000),
                          Color(0x22000000),
                          Color(0x66000000),
                        ],
                      ),
                    ),
                    child: Text(
                      movie.title?.toUpperCase() ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        fontFamily: 'Muli',
                        color: white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
