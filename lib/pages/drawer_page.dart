import 'package:demo_app/pages/login_page.dart';
import 'package:flutter/material.dart';

typedef IntCallback = void Function(int index);

class DrawerPage extends StatefulWidget {
  final IntCallback callback;

  const DrawerPage({Key key, @required this.callback}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final TextStyle textStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w300);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text('Alex Vegner'),
          accountEmail: Container(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              'ovegn@aux.dkatalis.com',
              style: TextStyle(fontSize: 28),
            ),
          ),
          decoration: BoxDecoration(
            image: new DecorationImage(
                fit: BoxFit.cover,
                image: new NetworkImage(
                    'https://hbimg.huabanimg.com/9bfa0fad3b1284d652d370fa0a8155e1222c62c0bf9d-YjG0Vt_fw658')),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.dashboard,
            size: 27.0,
          ),
          title: Text(
            'Dashboard',
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
            'Search',
            style: textStyle,
          ),
          onTap: () {
            setState(() {
              widget.callback(1);
              Navigator.of(context).pop();
            });
          },
        ),
        ListTile(
          leading: Icon(
            Icons.favorite,
            size: 27.0,
          ),
          title: Text(
            'Favorite',
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
            'Settings',
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
            'Logout',
            style: textStyle,
          ),
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => route == null);
          },
        )
      ],
    );
  }
}
