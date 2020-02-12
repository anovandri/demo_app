abstract class MovieFavoriteEvent {}

class MovieFavoriteFetchEvent extends MovieFavoriteEvent {
  MovieFavoriteFetchEvent();

  @override
  String toString() => "MovieFavoriteFetch:";
}

class MoviePopularFetchEvent extends MovieFavoriteEvent {
  MoviePopularFetchEvent();

  @override
  String toString() => "MoviePopularFetch";
}

class MovieFavoriteSaveEvent extends MovieFavoriteEvent {
  String id;
  String label;
  int priority;
  double rating;
  String title;
  int year;
  String poster;

  MovieFavoriteSaveEvent({this.id, this.label, this.priority, this.rating, this.title, this.year, this.poster});

  @override
  String toString() => "MovieFavoriteSave";

}

class MovieFavoriteClearFetchEvent extends MovieFavoriteEvent {
  MovieFavoriteClearFetchEvent();

  @override
  String toString() => "MovieFavoriteClearFetch";
}