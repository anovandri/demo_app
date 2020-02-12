import 'package:bloc/bloc.dart';
import 'package:indoxx1/data/omdb/repository/omdb_repository.dart';
import 'package:indoxx1/presentation/bloc/event/movie_event.dart';
import 'package:indoxx1/presentation/bloc/state/movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {

  @override
  MovieState get initialState => MovieUninitializedState();

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is MovieFetchEvent) {
      try {
        yield MovieLoadingState();
        final res = await OmdbRepository().listOfMovies(title: event.title, type: event.type, year: event.year);
        yield MovieLoadedState(res: res);
      } catch (_) {
        yield MovieErrorState();
      }
    }

    if (event is MovieDetailFetchEvent) {
      try {
        yield MovieLoadingState();
        final res = await OmdbRepository().getDetailMovie(id: event.id);
        yield MovieSingleLoadedState(res: res);
      } catch (_) {
        yield MovieErrorState();
      }
    }

    if (event is MovieClearFetchEvent) {
      try {
        yield MovieUninitializedState();
      } catch (_) {
        yield MovieErrorState();
      }
    }
  }
}