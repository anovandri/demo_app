import 'package:fluro/fluro.dart';
import 'package:indoxx1/routes/router_handle.dart';

class Routes {
  static String root = "/";
  static String login = "/login";
  static String home = "/home";
  static String detailMovie = "/detail-movie/:id";
  static String addUser = "/add-user";
  static String favorite = "/favorite";
  
  static void configureRoutes(Router router) {
    router.define(login, handler: loginHandler);
    router.define(home, handler: homeHandler);
    router.define(detailMovie, handler: detailMovieHandler);
    router.define(addUser, handler: addUserHandler);
    router.define(favorite, handler: null);
  }
}