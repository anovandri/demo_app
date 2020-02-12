import 'package:bloc/bloc.dart';
import 'package:indoxx1/data/indoxxi/repository/indoxxi_repository.dart';
import 'package:indoxx1/presentation/bloc/event/movie_favorite_event.dart';
import 'package:indoxx1/presentation/bloc/state/movie_favorite_state.dart';

class MovieFavoriteBloc extends Bloc<MovieFavoriteEvent, MovieFavoriteState> {
  @override
  MovieFavoriteState get initialState => MovieFavoriteUninitializedState();

  @override
  Stream<MovieFavoriteState> mapEventToState(MovieFavoriteEvent event) async* {
    if (event is MovieFavoriteFetchEvent) {
      try {
        yield MovieFavoriteLoadingState();
        final res = await IndoxxiRepository().listOfFavoriteMovies();
        yield MovieFavoriteLoadedState(res: res);
      } catch (_) {
        yield MovieFavoriteErrorState();
      }
    }

    if (event is MoviePopularFetchEvent) {
      try {
        yield MovieFavoriteLoadingState();
        final res = await IndoxxiRepository().listOfPopularMovies();
        yield MovieFavoriteLoadedState(res: res);
      } catch (_) {
        yield MovieFavoriteErrorState();
      }
    }

    if (event is MovieFavoriteSaveEvent) {
      try {
        final res = await IndoxxiRepository().addNewMovie(
            id: event.id,
            label: event.label,
            rating: event.rating,
            title: event.title,
            year: event.year,
            poster: event.poster);
        yield MovieFavoriteSaveState(res: res);
      } catch (_) {
        yield MovieFavoriteErrorState();
      }
    }

    if (event is MovieFavoriteClearFetchEvent) {
      try {
        yield MovieFavoriteUninitializedState();
      } catch (_) {
        yield MovieFavoriteErrorState();
      }
    }
  }
}
