import 'package:bloc/bloc.dart';
import 'package:indoxx1/data/indoxx1/repository/indoxxi_repository.dart';
import 'package:indoxx1/presentation/bloc/event/movie_favorite_event.dart';
import 'package:indoxx1/presentation/bloc/state/movie_favorite_state.dart';


class MovieFavoriteBloc extends Bloc<MovieFavoriteEvent, MovieFavoriteState> {

  @override
  MovieFavoriteState get initialState => MovieFavoriteUninitialized();

  @override
  Stream<MovieFavoriteState> mapEventToState(MovieFavoriteEvent event) async* {
    if (event is MovieFavoriteFetch) {
      try {
        yield MovieFavoriteLoading();
        final res = await IndoxxiRepository().listOfPopularMovies();
        yield MovieFavoriteLoaded(res: res);
      } catch (_) {
        yield MovieFavoriteError();
      }
    }

    if (event is MovieFavoriteClearFetch) {
      try {
        yield MovieFavoriteUninitialized();
      } catch (_) {
        yield MovieFavoriteError();
      }
    }
  }
}