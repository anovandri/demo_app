import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:indoxx1/common/network/indoxxi_ws_client.dart';
import 'package:indoxx1/data/indoxxi/datasource/indoxxi_datasource.dart';
import 'package:indoxx1/data/indoxxi/model/movie.dart';

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
  Future<List<MovieFavoriteModel>> listOfFavoriteMovies() async {
    Uri uri = Uri.https(INDOXXI_DOMAIN, DOMAIN_PATH);
    final response = await client.get(uri, headers: {
      'token':TOKEN,
    });
    String json = response.body;
    List<MovieFavoriteModel> movies = [];
    List<dynamic> movieDecoded = jsonDecode(json);
    movieDecoded.forEach((listItem) {
      movies.add(MovieFavoriteModel.movieFromJson(listItem as Map<String, dynamic>));
    });
    return movies;
  }

  @override
  Future<MovieFavoriteModel> getDetailMovie({String id}) async {
    Uri uri = Uri.https(INDOXXI_DOMAIN, DOMAIN_PATH + id);
    final response = await client.get(uri, headers : {
      'token': TOKEN,
    });
    String json = response.body;
    if (json != '') {
      Map<String, dynamic> movieDecoded = jsonDecode(json);
      MovieFavoriteModel movie = MovieFavoriteModel.movieFromJson(movieDecoded);
      return movie;
    }
    return null;
  }

  @override
  Future<String> addNewMovie({String id, String label, double rating, String title, int year, String poster}) async {
    var body = jsonEncode({
      'id': id,
      'label': label,
      'priority': 1,
      'viewed': false,
      'rating': rating,
      'timestamp': DateTime.now().toUtc().millisecondsSinceEpoch / 1000,
      'title': title,
      'year': year.toString(),
      'poster': poster,
    });
    Uri uri = Uri.https(INDOXXI_DOMAIN, DOMAIN_PATH);
    try {
      final response = await client.post(uri, headers: {
      'Content-Type': 'application/json',
      'token': TOKEN,
    }, body: body); 
    } catch (error) {
      print(error);
    }
    
    return label;
  }
}