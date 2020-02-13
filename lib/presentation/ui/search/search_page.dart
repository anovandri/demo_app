import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:indoxx1/presentation/bloc/event/movie_event.dart';
import 'package:indoxx1/presentation/ui/search/widget/omdb_list_widget.dart';
import 'package:indoxx1/routes/application.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  var _search = TextEditingController();

  _onSearch(BuildContext context) {
    String searchText = _search.text;
    movieBloc.add(MovieFetchEvent(title: searchText, type: 'movie'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchBar(
          children: <Widget>[
            OmdbListWidget(
              onItemInteraction: (movieId) {
                _navigateToMovieDetail(context, movieId);
              },
            )
          ],
          controller: _search,
          trailing: CircleAvatar(
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                //showSearch(context: null, delegate: null);
                _onSearch(context);
              },
            ),
            backgroundColor: Colors.transparent,
          ),
          onTap: () {},
          decoration:
              InputDecoration.collapsed(hintText: "Search by title ..."),
          ),
    );
  }

  _navigateToMovieDetail(BuildContext context, String movieId) {
    Application.router.navigateTo(context, '/detail-movie/$movieId', transition: TransitionType.native);
  }
}
