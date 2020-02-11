abstract class MovieFavoriteState {}

class MovieFavoriteError extends MovieFavoriteState {
  @override
  String toString() => "MovieFavoriteError";
}

class MovieFavoriteUninitialized extends MovieFavoriteState {
  @override
  String toString() => "MovieFavoriteUninitialized";
}

class MovieFavoriteLoading extends MovieFavoriteState {
  @override
  String toString() => "MovieFavoriteLoading";
}

class MovieFavoriteLoaded extends MovieFavoriteState {
  final List res;

  MovieFavoriteLoaded({
    this.res,
  });

  @override
  String toString() => "MovieFavoriteLoaded";
}