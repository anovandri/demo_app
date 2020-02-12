import 'package:indoxx1/data/indoxxi/model/movie.dart';

abstract class IndoxxiDatasource {
  Future init({bool isCreate});

  Future<List<MovieFavoriteModel>> listOfFavoriteMovies();

  Future<MovieFavoriteModel> getDetailMovie({String id});

  Future<String> addNewMovie({String id, String label, double rating, String title, int year, String poster});

}