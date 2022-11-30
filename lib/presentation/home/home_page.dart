import 'package:flutter/material.dart';
import 'package:structureflutter/data/movie_type.dart';
import 'package:structureflutter/presentation/home/widget/list_movie_by_type_view.dart';
import 'package:structureflutter/presentation/home/widget/now_playing_slider_view.dart';
import 'package:structureflutter/presentation/list_movie/list_movie.dart';

import '../../utils/theme/colors.dart';

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
                const NowPlayingSliderView(),
                const Divider(height: 8.0, color: Colors.transparent),
                ListMovieByTypeView(
                  movieType: MovieType.popular,
                  actionSeeAll: (movieType) {
                    _openListMovie(movieType);
                  },
                ),
                ListMovieByTypeView(
                  movieType: MovieType.topRated,
                  actionSeeAll: (movieType) {
                    _openListMovie(movieType);
                  },
                ),
                ListMovieByTypeView(
                  movieType: MovieType.upcoming,
                  actionSeeAll: (movieType) {
                    _openListMovie(movieType);
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
        return ListMovie(movieType: movieType);
      }),
    );
  }
}
