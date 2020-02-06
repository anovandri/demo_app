import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: FloatAppBar(
        
      ),
    );
  }
}

class FloatAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return (FloatingSearchBar(
      trailing: CircleAvatar(
        child: Text("RD"),
      ),
      onChanged: (String value) {},
      onTap: () {},
      decoration: InputDecoration.collapsed(
        hintText: "Title...",
      ),
      children: [],
    ));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
