import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:indoxx1/common/util/shared_preferences.dart';
import 'package:indoxx1/common/util/shared_preferences_key.dart';
import 'package:indoxx1/routes/application.dart';
import 'package:indoxx1/routes/routes.dart';
import 'package:path/path.dart';

typedef IntCallback = void Function(int index);

class DrawerPage extends StatefulWidget {
  final IntCallback callback;

  const DrawerPage({Key key, @required this.callback}) : super(key: key);
  
  @override
  _DrawerPage createState() => _DrawerPage();

}

class _DrawerPage extends State<DrawerPage> {
  String tokenId;
  String name;
  String email;

  final TextStyle textStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,
  );

  @override
  initState() {
    super.initState();
    SpUtil.getInstance().then((value) {
      setState(() {
        tokenId = value.getString(SharedPreferencesKeys.tokenId);
        name = value.getString(SharedPreferencesKeys.name);
        email = value.getString(SharedPreferencesKeys.email);  
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(
            name,
            style: TextStyle(
              color: Colors.red[300],
              decorationStyle: TextDecorationStyle.solid,
              fontWeight: FontWeight.bold,
            ),
          ),
          accountEmail: Container(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              email,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.red[300],
                decorationStyle: TextDecorationStyle.solid,
              ),
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: new NetworkImage(
                  join("https://api.adorable.io/avatars/150", tokenId+'.png') ),
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.dashboard,
            size: 27.0,
          ),
          title: Text(
            "Dashboard",
            style: textStyle,
          ),
          onTap: () {
            widget.callback(0);
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          leading: Icon(
            Icons.search,
            size: 27.0,
          ),
          title: Text(
            "Search",
            style: textStyle,
          ),
          onTap: () {
            widget.callback(1);
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          leading: Icon(
            Icons.favorite,
            size: 27.0,
          ),
          title: Text(
            "Favorite",
            style: textStyle,
          ),
          onTap: () {
            widget.callback(2);
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            size: 27.0,
          ),
          title: Text(
            "Settings",
            style: textStyle,
          ),
          onTap: () {
            widget.callback(3);
            Navigator.of(context).pop();
          },
        ),
        new Divider(),
        ListTile(
          title: Text(
            "Logout",
            style: textStyle,
          ),
          onTap: () {
            Application.router.navigateTo(context, Routes.login,
                transition: TransitionType.native);
          },
        ),
      ],
    );
  }
}
