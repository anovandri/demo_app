import 'package:indoxx1/data/omdb/model/base.dart';

class MovieFavoriteModel extends BaseModel {
  String _id;
  String _title;
  int _year;
  String _poster;
  String _label;
  int _priority;
  bool _viewed;
  int _rating;
  int _timestamp;

  MovieFavoriteModel.movieFromJson (Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    _title = parsedJson['title'];
    _year = int.parse(parsedJson['year'].toString().trim());
    _poster = parsedJson['poster'];
    _label = parsedJson['label']; 
    _priority = int.parse(parsedJson['priority'].toString().trim());
    _viewed = parsedJson['viewed'].toString().toLowerCase() == 'true';
    _rating = int.parse(parsedJson['rating'].toString().trim());
    _timestamp = int.parse(parsedJson['timestamp'].toString().trim());
  }

  String get id => _id;
  String get title => _title;
  int get year => _year;
  String get poster => _poster;
  String get label => _label;
  int get priority => _priority;
  bool get viewed => _viewed;
  int get rating => _rating;
  int get timestamp => _timestamp;
}