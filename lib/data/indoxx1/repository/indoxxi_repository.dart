import 'package:indoxx1/data/indoxx1/datasource/indoxxi_datasource.dart';
import 'package:indoxx1/data/indoxx1/datasource/indoxxi_local_datasource.dart';
import 'package:indoxx1/data/indoxx1/datasource/indoxxi_remote_datasource.dart';
import 'package:indoxx1/data/indoxx1/model/movie.dart';

class IndoxxiRepository {

  final IndoxxiDatasource indoxxiLocalDatasource = IndoxxiLocalDatasourceImpl();
  final IndoxxiDatasource indoxxiRemoteDatasource = IndoxxiRemoteDatasourceImpl.create();

  Future init({bool isCreate}) => indoxxiLocalDatasource.init(isCreate: isCreate);

  Future<List<MovieModel>> listOfPopularMovies() {
    return indoxxiRemoteDatasource.listOfPopularMovies();
  }

}