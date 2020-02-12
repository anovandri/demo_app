import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:indoxx1/common/util/my_scroll_behavior.dart';
import 'package:indoxx1/presentation/bloc/movie_bloc.dart';
import 'package:indoxx1/presentation/ui/dashboard/widget/movie_favorite_list.dart';
import 'package:indoxx1/presentation/ui/dashboard/widget/movie_omdb_list.dart';
import 'package:indoxx1/presentation/ui/dashboard/widget/slideshow.dart';
import 'package:indoxx1/routes/application.dart';

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
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SlideShowView(
                      onItemInteraction: (imdbId) {},
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    _buildMyFavoriteList(context),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    _buildMyOmdbList(context),
                  ],
                ),
              )),
        ));
  }

  _buildMyFavoriteList(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  'My Favorites',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Muli",
                  ),
                )),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          MovieFavoriteListView(
            onItemInteraction: (movieId) {
              _navigateToMovieDetail(context, movieId);
            },
          ),
        ],
      ),
    );
  }

  _buildMyOmdbList(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  'All Movies (Random)',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Muli",
                  ),
                )),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          MovieOmdbListView(
            onItemInteraction: (movieId) {
              _navigateToMovieDetail(context, movieId);
            },
          ),
        ],
      ),
    );
  }

  _navigateToMovieDetail(BuildContext context, String movieId) {
    Application.router.navigateTo(context, '/detail-movie/$movieId', transition: TransitionType.native);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
