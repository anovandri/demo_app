import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:indoxx1/presentation/ui/favorite/widget/favorite_list_widget.dart';
import 'package:indoxx1/routes/application.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FavoriteListWidget(
        onItemInteraction: (movieId) {
          _navigateToMovieDetail(context, movieId);
        },
      ),
    );
  }

  _navigateToMovieDetail(BuildContext context, String movieId) {
    Application.router.navigateTo(context, '/detail-movie/$movieId',
        transition: TransitionType.native);
  }
}
