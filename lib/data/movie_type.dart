import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/resource_string.dart';

enum MovieType {
  nowPlaying,
  popular,
  topRated,
  upcoming,
}

extension MovieTypeExtension on MovieType {
  String get value {
    switch (this) {
      case MovieType.nowPlaying:
        return 'now_playing';
      case MovieType.popular:
        return 'popular';
      case MovieType.topRated:
        return 'top_rated';
      case MovieType.upcoming:
        return 'upcoming';
    }
  }

  String getLabel(BuildContext context) {
    switch (this) {
      case MovieType.nowPlaying:
        return AppLocalizations.of(context)?.nowPlaying ?? '';
      case MovieType.popular:
        return AppLocalizations.of(context)?.popular ?? '';
      case MovieType.topRated:
        return AppLocalizations.of(context)?.topRate ?? '';
      case MovieType.upcoming:
        return AppLocalizations.of(context)?.upComing ?? '';
    }
  }
}
