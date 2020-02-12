import 'package:indoxx1/data/omdb/model/movie.dart';

abstract class OmdbDatasource {

  Future<List<MovieModel>> listOfMovies({String apiKey, String title, String type, int year});

  Future<MovieModel> getDetailMovie({String apiKey, String id});

}