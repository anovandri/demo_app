import 'package:demo_app/model/movie.dart';
import 'package:demo_app/model/user.dart';

class FavoriteModel {
  UserModel user;
  MovieModel movie;
  bool viewed;
  int priority;
  DateTime createdDate;
  DateTime updatedDate;

  FavoriteModel(UserModel user, MovieModel movie, {bool viewed, int priority}) {
    this.user = user;
    this.movie = movie;
    this.viewed ??= false; 
    this.priority ??= 1;
  }
}