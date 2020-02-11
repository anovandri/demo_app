abstract class MovieFavoriteEvent {}

class MovieFavoriteFetch extends MovieFavoriteEvent {
  MovieFavoriteFetch();

  @override
  String toString() => "MovieFavoriteFetch:";
}

class MovieFavoriteClearFetch extends MovieFavoriteEvent {
  MovieFavoriteClearFetch();

  @override
  String toString() => "MovieFavoriteClearFetch";
}