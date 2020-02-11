import 'package:indoxx1/data/omdb/datasource/omdb_datasource.dart';
import 'package:indoxx1/data/omdb/datasource/omdb_remote_datasource.dart';
import 'package:indoxx1/data/omdb/model/movie.dart';

class OmdbRepository {
  static const String API_KEY = "1665f88";

  final OmdbDatasource omdbRemoteDatasource = OmdbRemoteDatasourceImpl.create();

  Future<List<MovieModel>> listOfMovies({String title, String type, int year}) => omdbRemoteDatasource.listOfMovies(
      apiKey: API_KEY, title: title, type: type, year: year);
}
