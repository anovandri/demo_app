import 'package:bloc/bloc.dart';
import 'package:indoxx1/data/omdb/repository/omdb_repository.dart';
import 'package:indoxx1/presentation/bloc/event/movie_event.dart';
import 'package:indoxx1/presentation/bloc/state/movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {

  @override
  MovieState get initialState => MovieUninitialized();

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is MovieFetch) {
      try {
        yield MovieLoading();
        final res = await OmdbRepository().listOfMovies(title: event.title, type: event.type, year: event.year);
        yield MovieLoaded(res: res);
      } catch (_) {
        yield MovieError();
      }
    }

    if (event is MovieClearFetch) {
      try {
        yield MovieUninitialized();
      } catch (_) {
        yield MovieError();
      }
    }
  }
}