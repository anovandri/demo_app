import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:indoxx1/presentation/ui/splash/splash_page.dart';
import 'package:indoxx1/routes/application.dart';
import 'package:indoxx1/routes/routes.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  _WelcomePage createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomePage> {
  int themeColor = 0xFFC91B3A;
  
  Widget _buildWelcomePage() {
    return SplashPage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Indo XX1",
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
        )
      ),
      home: new Scaffold(
        body: this._buildWelcomePage(),
      ),
    );
  }
}