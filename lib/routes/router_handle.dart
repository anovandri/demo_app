import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:indoxx1/presentation/ui/login/login_page.dart';

var loginHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new LoginPage();
});
