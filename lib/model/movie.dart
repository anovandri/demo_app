import 'package:demo_app/model/crew.dart';
import 'package:demo_app/model/genre.dart';
import 'package:demo_app/model/language.dart';
import 'package:demo_app/model/rating.dart';

class MovieModel {
  String title;
  int year;
  String rated;
  DateTime released;
  int durationInMinute;
  List<Genre> genres;
  List<CrewModel> crews;
  String plot;
  List<LanguageModel> languages;
  String country;
  String awards;
  String poster;
  List<RatingModel> ratings;
  String type;
  DateTime dvdReleased;
  String boxOffice;
  String production;
  String webSite;
  String response;
}