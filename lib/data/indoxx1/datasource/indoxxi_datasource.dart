import 'package:indoxx1/data/indoxx1/model/movie.dart';

abstract class IndoxxiDatasource {
  Future init({bool isCreate});

  Future<List<MovieModel>> listOfPopularMovies();
  
}