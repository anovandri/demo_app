import 'package:demo_app/routers/application.dart';
import 'package:demo_app/routers/routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {

  }

@override
  Widget build(BuildContext context) {

  }
}
