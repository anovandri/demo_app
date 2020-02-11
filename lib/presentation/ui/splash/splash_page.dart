import 'dart:async';

import 'package:flutter/material.dart';
import 'package:indoxx1/presentation/ui/login/login_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashStatePage createState() => _SplashStatePage();
}

class _SplashStatePage extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    this._startSplash();
  }

  _startSplash() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return LoginPage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: 200.0,
          height: 100.0,
        ),
      ),
    );
  }
}