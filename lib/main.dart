import 'package:flutter/material.dart';
import 'package:indoxx1/data/indoxxi/repository/user_repository.dart';
import 'package:indoxx1/presentation/welcome_page.dart';

var db;

void main() async {
  //debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  await UserRepository().init(isCreate: true);
  runApp(MaterialApp(
    title: 'Indo XX1',
    home: WelcomePage(),
  ));
}