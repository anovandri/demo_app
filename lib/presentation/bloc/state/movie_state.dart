import 'package:indoxx1/data/omdb/model/movie.dart';

abstract class MovieState {}

class MovieErrorState extends MovieState {
  @override
  String toString() => "MovieError";
}

class MovieUninitializedState extends MovieState {
  @override
  String toString() => "MovieUninitialized";
}

class MovieLoadingState extends MovieState {
  @override
  String toString() => "MovieLoading";
}

class MovieLoadedState extends MovieState {
  final List res;

  MovieLoadedState({
    this.res
  });

  @override
  String toString() => "MovieLoaded";
}

class MovieSingleLoadedState extends MovieState {
  final MovieModel res;

  MovieSingleLoadedState({
    this.res
  });

  @override
  String toString() => "MovieSingleLoaded";
}