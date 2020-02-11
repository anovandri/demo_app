import 'package:flutter/material.dart';
import 'package:indoxx1/common/util/utilities.dart';
import 'package:indoxx1/data/omdb/model/base.dart';
import 'package:indoxx1/data/omdb/model/crew.dart';
import 'package:indoxx1/data/omdb/model/rating.dart';

class MovieModel extends BaseModel {
  String _imdbId;
  String _title;
  int _year;
  String _rated;
  DateTime _dateReleased;
  int _durationInTime;
  String _genre;
  List<CrewModel> _crews = [];
  String _plot;
  String _language;
  String _country;
  String _awards;
  String _poster;
  List<RatingModel> _ratings = [];
  String _type;
  DateTime _dvdReleased;
  String _boxOffice;
  String _production;
  String _webSite;
  String _response;

  MovieModel.detailMovieFromJson(Map<String, dynamic> parsedJson) {
    _imdbId = parsedJson['imdbID'];
    _title = parsedJson['Title'];
    _year = int.parse(parsedJson['Year']);
    _rated = parsedJson['Rated'];
    _dateReleased = Util.convertDateFromString(parsedJson['Released']);
    _durationInTime = int.parse(parsedJson['Runtime']);
    _genre = parsedJson['Genre'];
    _crews.addAll(this
        ._generateCrews(crewList: parsedJson['Director'], role: 'director'));
    _crews.addAll(
        this._generateCrews(crewList: parsedJson['Actors'], role: 'actor'));
    _crews.addAll(
        this._generateCrews(crewList: parsedJson['Writer'], role: 'writer'));
    _plot = parsedJson['Plot'];
    _language = parsedJson['Language'];
    _country = parsedJson['Country'];
    _awards = parsedJson['Awards'];
    _poster = parsedJson['Poster'];
    this._generateRatings(parsedJson['Ratings']);
    _type = parsedJson['Type'];
    _dvdReleased = Util.convertDateFromString(parsedJson['DVD']);
    _boxOffice = parsedJson['BoxOffice'];
    _production = parsedJson['Production'];
    _webSite = parsedJson['Website'];
    _response = parsedJson['Response'];
  }

  MovieModel.movieFromJson(Map<String, dynamic> parsedJson) {
    _imdbId = parsedJson['imdbId'];
    _year = int.parse(parsedJson['Year']);
    _title = parsedJson['Title'];
    _type = parsedJson['Type'];
    _poster = parsedJson['Poster'];
  }

  String get imdbId => _imdbId;
  String get title => _title;
  int get year => _year;
  String get rated => _rated;
  DateTime get dateReleased => _dateReleased;
  int get durationInTime => _durationInTime;
  String get genre => _genre;
  List<CrewModel> get crews => _crews;
  String get plot => _plot;
  String get language => _language;
  String get country => _country;
  String get awards => _awards;
  String get poster => _poster;
  List<RatingModel> get ratings => _ratings;
  String get type => _type;
  DateTime get dvdReleased => _dvdReleased;
  String get boxOffice => _boxOffice;
  String get production => _production;
  String get webSite => _webSite;
  String get response => _response; 

  List<CrewModel> _generateCrews(
      {@required List<String> crewList, @required String role}) {
    List<CrewModel> crews = [];
    if (crewList != null) {
      for (String crew in crewList) {
        CrewModel model = CrewFactory(name: crew, role: role).getCrew();
        crews.add(model);
      }
    }
    return crews;
  }

  List<RatingModel> _generateRatings(dynamic ratings) {
    for (var rating in ratings) {
      _ratings.add(RatingModel.fromJson(rating));
    }
  }
}
