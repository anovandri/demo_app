import 'package:demo_app/pages/login_page.dart';
import 'package:demo_app/routers/application.dart';
import 'package:demo_app/routers/routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyAppPage extends StatefulWidget {
  
  MyAppPage() {
    final router = new Router();
    Routers.configureRoutes(router);
    Application.router = router;
  }

  @override
  _MyAppPage createState() => _MyAppPage();
}

class _MyAppPage extends State<MyAppPage> {

  int themeColor = 0xFFC91B3A;

  @override
  void initState() {

  }

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'titles',
      theme: new ThemeData(
        primaryColor: Color(this.themeColor),
        backgroundColor: Color(0xFFEFEFEF),
        accentColor: Color(0xFF888888),
        textTheme: TextTheme(
          body1: TextStyle(color: Color(0xFF888888), fontSize: 16.0),
        ),
        iconTheme: IconThemeData(
          color: Color(this.themeColor),
          size: 35.0,
        ),
      ),
      home: new Scaffold(
        body: showWelcomePage(),
      ),
    );
  }

  showWelcomePage() {
    return LoginPage();
  }
}
