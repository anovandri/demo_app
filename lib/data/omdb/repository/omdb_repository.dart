import 'package:indoxx1/data/indoxxi/model/movie.dart';
import 'package:indoxx1/data/indoxxi/repository/indoxxi_repository.dart';
import 'package:indoxx1/data/omdb/datasource/omdb_datasource.dart';
import 'package:indoxx1/data/omdb/datasource/omdb_remote_datasource.dart';
import 'package:indoxx1/data/omdb/model/movie.dart';

class OmdbRepository {
  static const String API_KEY = "1665f88";

  final OmdbDatasource omdbRemoteDatasource = OmdbRemoteDatasourceImpl.create();
  final IndoxxiRepository indoxxiRepository = IndoxxiRepository();

  Future<List<MovieModel>> listOfMovies({String title, String type, int year}) => omdbRemoteDatasource.listOfMovies(
      apiKey: API_KEY, title: title, type: type, year: year);

  Future<MovieModel> getDetailMovie({String id}) async {
    MovieModel movie = await omdbRemoteDatasource.getDetailMovie(apiKey: API_KEY, id: id);
    MovieFavoriteModel movieFavorite = await indoxxiRepository.getDetailMovie(id: movie.imdbId);
    if (movieFavorite != null && movieFavorite.id != null) {
      movie.isFavorite = true;
    } else {
      movie.isFavorite = false;
    }
    return movie;
  } 
}
