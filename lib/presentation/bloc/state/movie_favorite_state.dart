abstract class MovieFavoriteState {}

class MovieFavoriteErrorState extends MovieFavoriteState {
  @override
  String toString() => "MovieFavoriteError";
}

class MovieFavoriteUninitializedState extends MovieFavoriteState {
  @override
  String toString() => "MovieFavoriteUninitialized";
}

class MovieFavoriteLoadingState extends MovieFavoriteState {
  @override
  String toString() => "MovieFavoriteLoading";
}

class MovieFavoriteLoadedState extends MovieFavoriteState {
  final List res;

  MovieFavoriteLoadedState({
    this.res,
  });

  @override
  String toString() => "MovieFavoriteLoaded";
}

class MovieFavoriteSaveState extends MovieFavoriteState {
  final String res;

  MovieFavoriteSaveState({
    this.res,
  });

  @override
  String toString() => "MovieFavoriteSave";
}