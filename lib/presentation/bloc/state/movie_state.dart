abstract class MovieState {}

class MovieError extends MovieState {
  @override
  String toString() => "MovieError";
}

class MovieUninitialized extends MovieState {
  @override
  String toString() => "MovieUninitialized";
}

class MovieLoading extends MovieState {
  @override
  String toString() => "MovieLoading";
}

class MovieLoaded extends MovieState {
  final List res;

  MovieLoaded({
    this.res
  });

  @override
  String toString() => "MovieLoaded";
}