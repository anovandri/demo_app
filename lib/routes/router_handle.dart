import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:indoxx1/presentation/ui/add-user/add_user.dart';
import 'package:indoxx1/presentation/ui/detail/movie_detail.dart';
import 'package:indoxx1/presentation/ui/home/home_page.dart';
import 'package:indoxx1/presentation/ui/login/login_page.dart';

var loginHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new LoginPage();
});

var homeHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new HomePage();
});

var detailMovieHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params['id']?.first;
  return new MovieDetailView(id: id,);
}); 

var addUserHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new AddUserPage();
});

var favorite = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return null;
});
