abstract class MovieEvent {}

class MovieFetchEvent extends MovieEvent {
  String title;
  String type;
  int year;
  
  MovieFetchEvent({this.title, this.type, this.year});

  @override
  String toString() => "MovieFetch:";
}

class MovieDetailFetchEvent extends MovieEvent {
  String id;

  MovieDetailFetchEvent({this.id});

  @override
  String toString() => "MovieDetailFetch:";
}

class MovieClearFetchEvent extends MovieEvent {
  String title;
  String type;
  int year;

  MovieClearFetchEvent({this.title, this.type, this.year});

  @override
  String toString() => "MovieClearFetch";
}