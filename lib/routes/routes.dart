import 'package:fluro/fluro.dart';
import 'package:indoxx1/routes/router_handle.dart';

class Routes {
  static String root = "/";
  static String login = "/login";
  static String home = "/home";
  
  static void configureRoutes(Router router) {
    router.define(login, handler: loginHandler);
    router.define(home, handler: homeHandler);
  }
}