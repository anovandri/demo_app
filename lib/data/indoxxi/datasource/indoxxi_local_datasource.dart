import 'package:indoxx1/data/indoxxi/datasource/indoxxi_datasource.dart';
import 'package:indoxx1/data/indoxxi/model/movie.dart';
import 'package:sqflite/sqflite.dart';

class IndoxxiLocalDatasourceImpl implements IndoxxiDatasource {
  static Database db;

  @override
  Future<List<MovieFavoriteModel>>  listOfFavoriteMovies() async {}

  @override
  Future<MovieFavoriteModel> getDetailMovie({String id}) async {}

  @override
  Future<String> addNewMovie({String id, String label, double rating, int timestamp, String title, int year, String poster}) {}
}
