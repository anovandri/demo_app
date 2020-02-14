import 'package:flutter/material.dart';

class IconButtonActionWidget extends StatefulWidget {
  @override
  _IconButtonActionWidgetState createState() => _IconButtonActionWidgetState();
}

class _IconButtonActionWidgetState extends State<IconButtonActionWidget> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        icon: Icon(Icons.settings),
        itemBuilder: (BuildContext context) {
          return Constants.choices.map((String choice) {
            return PopupMenuItem<String>(child: Text(choice),value: choice,);
          }).toList();
        },
        onSelected: (String result) {
          print(result);
        },);
  }
}

class Constants {
  static const String FirstItem = 'Edit Favorite Movie';
  static const String SecondItem = 'Delete Favorite Item';
  
  static const List<String> choices = <String>[
    FirstItem,
    SecondItem,
  ];
}
