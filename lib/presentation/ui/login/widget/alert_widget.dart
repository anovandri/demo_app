import 'package:flutter/material.dart';

class AlertWidget extends StatelessWidget {
  String message;

  AlertWidget({this.message});

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Indo XX1"),
      content: Text(this.message),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text('OK')),
      ],
    );
  }
}
