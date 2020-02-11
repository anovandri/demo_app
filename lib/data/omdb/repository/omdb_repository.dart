import 'package:indoxx1/data/omdb/datasource/omdb_datasource.dart';
import 'package:indoxx1/data/omdb/datasource/omdb_remote_datasource.dart';
import 'package:indoxx1/data/omdb/model/movie.dart';

class OmdbRepository {
  static const String API_KEY = "1665f88";

  final OmdbDatasource omdbRemoteDatasource = OmdbRemoteDatasourceImpl.create();

  Future<List<MovieModel>> listOfMovies() => omdbRemoteDatasource.listOfMovies(
      apiKey: API_KEY, title: 'John', type: 'movie', year: 2019);
}
