import 'package:flutter/material.dart';

import '../data/model/movie.dart';
import '../utils/theme/colors.dart';
import 'home/widget/category_view.dart';
import 'home/widget/my_list_view.dart';
import 'home/widget/popular_view.dart';
import 'home/widget/slider_view.dart';

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
            child: Container(
              child: Column(
                children: [
                  SliderView(
                    actionOpenMovie: (movie) {
                      _openMovieDetail(movie);
                    },
                  ),
                  Divider(height: 4.0, color: Colors.transparent),
                  CategoryView(
                    actionOpenCategory: (movie) {
                      _openMovieDetail(movie);
                    },
                  ),
                  Divider(height: 8.0, color: Colors.transparent),
                  MyListView(
                    actionOpenMovie: (movie) {
                      _openMovieDetail(movie);
                    },
                    actionLoadAll: () {},
                  ),
                  Divider(height: 8.0, color: Colors.transparent),
                  PopularView(
                    actionOpenMovie: (movie) {
                      _openMovieDetail(movie);
                    },
                    actionLoadAll: () {},
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _openMovieDetail(Movie movie) async {
    // await Navigator.of(context).push(
    //   MaterialPageRoute(builder: (_) {
    //     return DetailScreen(movie: movie);
    //   }),
    // );
  }
}
