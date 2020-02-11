import 'package:flutter/material.dart';
import 'package:indoxx1/data/indoxx1/repository/indoxxi_repository.dart';
import 'package:indoxx1/presentation/welcome_page.dart';

var db;

void main() async {
  //debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  await IndoxxiRepository().init(isCreate: true);
  runApp(MaterialApp(
    title: 'Indo XX1',
    home: WelcomePage(),
  ));
}