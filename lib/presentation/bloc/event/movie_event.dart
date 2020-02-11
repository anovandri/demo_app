abstract class MovieEvent {}

class MovieFetch extends MovieEvent {
  String title;
  String type;
  int year;
  
  MovieFetch({this.title, this.type, this.year});

  @override
  String toString() => "MovieFetch:";
}

class MovieClearFetch extends MovieEvent {
  String title;
  String type;
  int year;

  MovieClearFetch({this.title, this.type, this.year});

  @override
  String toString() => "MovieClearFetch";
}