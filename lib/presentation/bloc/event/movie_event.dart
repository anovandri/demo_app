abstract class MovieEvent {}

class MovieFetch extends MovieEvent {
  final String query;

  MovieFetch({this.query});

  @override
  String toString() => "MovieFetch:";
}

class MovieClearFetch extends MovieEvent {
  final String query;

  MovieClearFetch({this.query});

  @override
  String toString() => "MovieClearFetch";
}