import 'package:flutter/material.dart';
import 'package:indoxx1/presentation/ui/dashboard/dashboard_page.dart';
import 'package:indoxx1/presentation/ui/drawer/drawer_page.dart';
import 'package:indoxx1/presentation/ui/favorite/favorite_page.dart';
import 'package:indoxx1/presentation/ui/search/search_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String _appBarTitle = "Dashboard";
  dynamic _contentBody = DashboardPage();
  
  Widget _onPageSelected(int index, {BuildContext context}) {
    switch (index) {
      case 0:
        setState((){
          this._appBarTitle = "Dashboard";
          this._contentBody = DashboardPage();
        });
        break;
      case 1:
        setState(() {
          this._appBarTitle = "Search Movie";
          this._contentBody = SearchPage();
        });
        break;
      case 2:
        setState(() {
          this._appBarTitle = "Favorite Movie";
          this._contentBody = FavoritePage();
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this._appBarTitle),
      ),
      drawer: Drawer(
        child: DrawerPage(callback: _onPageSelected),
      ),
      body: this._contentBody,
    );
  }
}