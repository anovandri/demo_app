import 'package:indoxx1/data/indoxxi/datasource/indoxxi_datasource.dart';
import 'package:indoxx1/data/indoxxi/datasource/indoxxi_local_datasource.dart';
import 'package:indoxx1/data/indoxxi/datasource/indoxxi_remote_datasource.dart';
import 'package:indoxx1/data/indoxxi/model/movie.dart';

class IndoxxiRepository {

  final IndoxxiDatasource indoxxiLocalDatasource = IndoxxiLocalDatasourceImpl();
  final IndoxxiDatasource indoxxiRemoteDatasource = IndoxxiRemoteDatasourceImpl.create();

  Future init({bool isCreate}) => indoxxiLocalDatasource.init(isCreate: isCreate);

  Future<List<MovieFavoriteModel>> listOfFavoriteMovies() async {
    return indoxxiRemoteDatasource.listOfFavoriteMovies();
  }

  Future<List<MovieFavoriteModel>> listOfPopularMovies() async {
    List<MovieFavoriteModel> responseMovies = [];
    List<MovieFavoriteModel> movies = await indoxxiRemoteDatasource.listOfFavoriteMovies();
    for(MovieFavoriteModel movie in movies) {
      if (movie.priority > 3) {
          responseMovies.add(movie);
      }
    }
    return responseMovies;
  }

  Future<MovieFavoriteModel> getDetailMovie({String id}) => indoxxiRemoteDatasource.getDetailMovie(id: id);

  Future<String> addNewMovie({String id, String label, double rating, String title, int year, String poster}) =>
    indoxxiRemoteDatasource.addNewMovie(id: id, label: label, rating: rating, title: title, year: year, poster: poster);

}