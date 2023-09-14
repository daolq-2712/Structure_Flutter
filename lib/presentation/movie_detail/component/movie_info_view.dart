import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/resource_string.dart';

import '/business/movie_detail_bloc/movie_detail_bloc.dart';
import '/business/movie_detail_bloc/movie_detail_state.dart';
import '/data/model/movie.dart';
import '/data/model/movie_info.dart';
import '/data/repository/movie_repository_impl.dart';
import '/presentation/widget/error_page.dart';
import '../../widget/star_rating_widget.dart';

class MovieInfoView extends StatefulWidget {
  final Movie movie;

  const MovieInfoView({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieInfoView> createState() => _MovieInfoViewState();
}

class _MovieInfoViewState extends State<MovieInfoView> {
  late MovieDetailBloc _movieDetailBloc;
  final ValueNotifier<bool> _expandDescription = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _movieDetailBloc = MovieDetailBloc(MovieRepositoryImpl());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _movieDetailBloc.fetchMovieDetail(widget.movie.id ?? -1);
    });
  }

  @override
  void dispose() {
    _movieDetailBloc.dispose();
    _expandDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieDetailState>(
      stream: _movieDetailBloc.stateController.stream,
      initialData: MovieDetailInit(),
      builder: (context, snapshot) {
        var state = snapshot.data;
        if (state is GetMovieDetailError) {
          return ErrorPage(
            message: state.msg,
            retry: () {
              _movieDetailBloc.fetchMovieDetail(widget.movie.id ?? -1);
            },
          );
        } else if (state is GetMovieDetailSuccess) {
          return _createMovieBody(context, state.movieInfo);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createMovieBody(BuildContext context, MovieInfo info) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
          child: Text(
            info.title ?? '',
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
          child: Text(
            info.getCategories,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13.0,
              color: Colors.black45,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: StarRating(
            size: 24.0,
            rating: (info.voteAverage ?? 0) / 2,
            color: Colors.red,
            borderColor: Colors.black54,
            starCount: 5,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)?.year ?? '',
                    style: const TextStyle(
                      fontSize: 13.0,
                      color: Colors.black45,
                    ),
                  ),
                  Text(
                    info.year,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)?.country ?? '',
                    style: const TextStyle(
                      fontSize: 13.0,
                      color: Colors.black45,
                    ),
                  ),
                  Text(
                    info.country,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)?.length ?? '',
                    style: const TextStyle(
                      fontSize: 13.0,
                      color: Colors.black45,
                    ),
                  ),
                  Text(
                    info.runtime?.toString() ?? '',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        _createMovieOverview(context, info.overview ?? ''),
      ],
    );
  }

  Widget _createMovieOverview(BuildContext context, String overview) {
    return InkWell(
      onTap: () {
        _expandDescription.value = !_expandDescription.value;
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 24.0, right: 24.0, top: 8.0),
        child: ValueListenableBuilder(
          valueListenable: _expandDescription,
          builder: (BuildContext context, bool value, Widget? child) {
            return Text(
              overview,
              textAlign: TextAlign.justify,
              maxLines: value ? 100 : 5,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black45,
              ),
            );
          },
        ),
      ),
    );
  }
}
