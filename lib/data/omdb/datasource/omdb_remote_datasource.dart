import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:indoxx1/common/network/omdb_ws_client.dart';
import 'package:indoxx1/data/omdb/datasource/omdb_datasource.dart';
import 'package:indoxx1/data/omdb/model/movie.dart';

import 'package:http/http.dart' as http;

class OmdbRemoteDatasourceImpl implements OmdbDatasource {
  static const String OMDB_DOMAIN = "www.omdbapi.com";
  
  final OmdbWsClient client;

  OmdbRemoteDatasourceImpl({@required this.client}); 

  factory OmdbRemoteDatasourceImpl.create() {
    return OmdbRemoteDatasourceImpl(client: OmdbWsClientImpl(http.Client()));
  }
  
  @override
  Future<List<MovieModel>> listOfMovies(
    {String apiKey, String title, String type, int year}) async {
    Uri uri = Uri.http(OMDB_DOMAIN, "", {
      'apiKey': apiKey,
      's': title,
      'type': type,
      //'y': year.toString(),
    });
    final response = await client.get(uri);
    String json = response.body;
    List<MovieModel> movies = [];
    Map<String, dynamic> decodedJson = jsonDecode(json);
    List<dynamic> movieDecoded = decodedJson['Search'];
    movieDecoded.forEach((listItem) {
      movies.add(MovieModel.movieFromJson(listItem as Map<String, dynamic>));
    });
    return movies;
  }

  @override
    Future<MovieModel> getDetailMovie({String apiKey, String id}) async {
    Uri uri = Uri.http(OMDB_DOMAIN, "", {
      'apiKey': apiKey,
      'i': id,
    });
    final response = await client.get(uri);
    String json = response.body;
    Map<String, dynamic> decodedJson = jsonDecode(json);
    return MovieModel.detailMovieFromJson(decodedJson);
  }

}