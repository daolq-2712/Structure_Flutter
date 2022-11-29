import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '/business/movie_bloc/movie_bloc.dart';
import '/business/movie_bloc/movie_state.dart';
import '/data/repository/movie_repository_impl.dart';
import '/utils/constant.dart';

class TrendingSliderView extends StatefulWidget {
  const TrendingSliderView({Key? key}) : super(key: key);

  @override
  State<TrendingSliderView> createState() => _TrendingSliderViewState();
}

class _TrendingSliderViewState extends State<TrendingSliderView> {
  late MovieBloc _movieBloc;

  @override
  void initState() {
    super.initState();
    _movieBloc = MovieBloc(MovieRepositoryImpl());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _movieBloc.fetchMovieNowPlaying();
    });
  }

  @override
  void dispose() {
    _movieBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return StreamBuilder<MovieState>(
      stream: _movieBloc.stateController.stream,
      initialData: MovieStateInit(),
      builder: (BuildContext context, AsyncSnapshot<MovieState> snapshot) {
        var state = snapshot.data;
        if (state is MovieStateInit) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MovieFetched) {
          final movies = state.movies;
          return CarouselSlider.builder(
            itemCount: movies.length,
            itemBuilder: (context, index, realIndex) {
              final movie = movies[index];

              return Card(
                elevation: 10.0,
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: CachedNetworkImage(
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  imageUrl: '${Constant.prefixImageUrl}${movie.backdropPath}',
                  width: width,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              );
            },
            options: CarouselOptions(
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
            ),
          );
        } else {
          return const Spacer();
        }
      },
    );
  }
}
