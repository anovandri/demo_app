import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:indoxx1/common/network/indoxxi_ws_client.dart';
import 'package:indoxx1/data/indoxx1/datasource/indoxxi_datasource.dart';
import 'package:indoxx1/data/indoxx1/model/movie.dart';

import 'package:http/http.dart' as http;

class IndoxxiRemoteDatasourceImpl implements IndoxxiDatasource {
  static const String INDOXXI_DOMAIN = "demo-video-ws-chfmsoli4q-ew.a.run.app";
  static const String DOMAIN_PATH = "video-ws/videos/";
  static const String TOKEN = "bec4k";

  final IndoxxiWsClient client;

  IndoxxiRemoteDatasourceImpl({@required this.client});
  
  factory IndoxxiRemoteDatasourceImpl.create() {
    return IndoxxiRemoteDatasourceImpl(client: IndoxxiWsClientImpl(http.Client()));
  }

  @override
  Future init({bool isCreate}) {}

  @override
  Future<List<MovieModel>> listOfPopularMovies() async {
    Uri uri = Uri.https(INDOXXI_DOMAIN, DOMAIN_PATH);
    final response = await client.get(uri, headers: {
      'token':TOKEN,
    });
    String json = response.body;
    List<MovieModel> movies = [];
    List<dynamic> movieDecoded = jsonDecode(json);
    movieDecoded.forEach((listItem) {
      movies.add(MovieModel.movieFromJson(listItem as Map<String, dynamic>));
    });
    return movies;
  }

}