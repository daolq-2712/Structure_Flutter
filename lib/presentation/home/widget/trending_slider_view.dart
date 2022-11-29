import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '/business/movies_bloc/movies_bloc.dart';
import '/business/movies_bloc/movies_state.dart';
import '/data/repository/movie_repository_impl.dart';
import '/utils/constant.dart';

class TrendingSliderView extends StatefulWidget {
  const TrendingSliderView({Key? key}) : super(key: key);

  @override
  State<TrendingSliderView> createState() => _TrendingSliderViewState();
}

class _TrendingSliderViewState extends State<TrendingSliderView> {
  late MoviesBloc _moviesBloc;

  @override
  void initState() {
    super.initState();
    _moviesBloc = MoviesBloc(MovieRepositoryImpl());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _moviesBloc.fetchMovieNowPlaying();
    });
  }

  @override
  void dispose() {
    _moviesBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return StreamBuilder<FetchMoviesState>(
      stream: _moviesBloc.stateController.stream,
      initialData: FetchMoviesStateInitialized(),
      builder:
          (BuildContext context, AsyncSnapshot<FetchMoviesState> snapshot) {
        var state = snapshot.data;
        if (state is FetchMoviesStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FetchMoviesSuccess) {
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
