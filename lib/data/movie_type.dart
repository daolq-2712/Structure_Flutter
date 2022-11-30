enum MovieType {
  nowPlaying,
  popular,
  topRated,
  upcoming,
}

extension MovieTypeExtension on MovieType {
  String get value {
    switch (this) {
      case MovieType.popular:
        return 'popular';
      case MovieType.nowPlaying:
        return 'now_playing';
      case MovieType.topRated:
        return 'top_rated';
      case MovieType.upcoming:
        return 'upcoming';
    }
  }
}
