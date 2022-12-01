import 'package:flutter/material.dart';

import '../../data/model/movie.dart';
import '../movie_detail/movie_detail_page.dart';
import '/data/movie_type.dart';
import '/presentation/home/component/list_movie_by_type_view.dart';
import '/presentation/home/component/now_playing_slider_view.dart';
import '/presentation/list_movie/list_movie_page.dart';
import '/utils/theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 4.0,
        backgroundColor: primaryColor,
        title: Image.asset(
          'assets/images/ic_netflix.png',
          height: 56.0,
          fit: BoxFit.fitHeight,
        ),
        centerTitle: true,
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.search, color: actionBarIconColor),
              onPressed: () {},
            ),
          ),
        ],
        elevation: 0.0,
      ),
      backgroundColor: backgroundColor,
      body: _createBody(context),
    );
  }

  Widget _createBody(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Column(
              children: [
                NowPlayingSliderView(
                  actionviewDetail: (movie) {
                    _openMovieDetail(movie);
                  },
                ),
                const Divider(height: 8.0, color: Colors.transparent),
                ListMovieByTypeView(
                  movieType: MovieType.popular,
                  actionSeeAll: (movieType) {
                    _openListMovie(movieType);
                  },
                  actionviewDetail: (movie) {
                    _openMovieDetail(movie);
                  },
                ),
                ListMovieByTypeView(
                  movieType: MovieType.topRated,
                  actionSeeAll: (movieType) {
                    _openListMovie(movieType);
                  },
                  actionviewDetail: (movie) {
                    _openMovieDetail(movie);
                  },
                ),
                ListMovieByTypeView(
                  movieType: MovieType.upcoming,
                  actionSeeAll: (movieType) {
                    _openListMovie(movieType);
                  },
                  actionviewDetail: (movie) {
                    _openMovieDetail(movie);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openListMovie(MovieType movieType) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        return ListMoviePage(movieType: movieType);
      }),
    );
  }

  void _openMovieDetail(Movie movie) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        return DetailScreen(movie: movie);
      }),
    );
  }
}
