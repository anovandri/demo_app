import 'package:demo_app/pages/dashboard_page.dart';
import 'package:demo_app/pages/drawer_page.dart';
import 'package:demo_app/pages/favorite_page.dart';
import 'package:demo_app/pages/search_page.dart';
import 'package:demo_app/pages/setting_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {

  String _appBarTitle = 'Dashboard';
  dynamic _contentBody;

  void _onPageSelected(int index) {
    switch (index) {
      case 0 :
        setState(() {
          this._appBarTitle = 'Dashboard';  
          _contentBody = DashboardPage();
        });
        break;
      case 1 :
        setState(() {
          this._appBarTitle = 'Search';  
          _contentBody = SearchPage();
        });
        break;
      case 2 :
        setState(() {
          this._appBarTitle = 'Favorite';  
          _contentBody = FavoritePage();
        });
        break;
      case 3 :
        setState(() {
          this._appBarTitle = 'Settings';  
          _contentBody = SettingPage();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          this._appBarTitle
        ),
      ),
      drawer: Drawer(
        child: DrawerPage(callback: _onPageSelected),
      ),
      body : this._contentBody
      ,
    );
  }
}