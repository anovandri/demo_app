import 'package:flutter/material.dart';
import 'package:indoxx1/common/util/my_scroll_behavior.dart';
import 'package:indoxx1/presentation/bloc/movie_bloc.dart';
import 'package:indoxx1/presentation/ui/dashboard/widget/movie_list.dart';
import 'package:indoxx1/presentation/ui/dashboard/widget/slideshow.dart';

final MovieBloc movie = MovieBloc();

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPage createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Container(
          color: Colors.white,
          child: ScrollConfiguration(
              behavior: MyScrollBehavior(),
              child: Column(
                children: <Widget>[
                  SlideShowView(
                    onItemInteraction: (imdbId) {},
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  _buildMyList(context),
                ],
              )),
        ));
  }

  _buildMyList(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  'My List',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Muli",
                  ),
                )),
                Icon(Icons.arrow_forward, color: Colors.black,),
              ],
            ),
          ),
          MovieListView(onItemInteraction: (movieId) {

          },),
        ],
      ),
    );
  }
}
