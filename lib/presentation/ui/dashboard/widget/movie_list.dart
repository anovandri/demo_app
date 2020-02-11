import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indoxx1/data/indoxx1/model/movie.dart';
import 'package:indoxx1/presentation/bloc/event/movie_favorite_event.dart';
import 'package:indoxx1/presentation/bloc/movie_favorite_bloc.dart';
import 'package:indoxx1/presentation/bloc/state/movie_favorite_state.dart';
import 'package:indoxx1/presentation/bloc/state/movie_state.dart';

final MovieFavoriteBloc movieFavoriteBloc = MovieFavoriteBloc();

class MovieListView extends StatefulWidget {
  final Function(String imdbId) onItemInteraction;

  MovieListView({Key key, this.onItemInteraction}) : super(key: key);

  @override
  _MovieListView createState() => _MovieListView();
} 

class _MovieListView extends State<MovieListView> {
  @override
  Widget build(BuildContext context) {
    movieFavoriteBloc.add(MovieFavoriteFetch());
    return Container(child: BlocBuilder(bloc: movieFavoriteBloc, builder: (BuildContext context, MovieFavoriteState state) {
          return renderItem(state);
    },));
  }

  Widget renderItem(state) {
    if (state is MovieFavoriteUninitialized) {
      return Center(
        child: Text('No content yet'),
      );
    } else if (state is MovieFavoriteLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is MovieFavoriteError) {
      return Center(
        child: Text('An error occured'),
      );
    } else if (state is MovieFavoriteLoaded) {
      if (state.res.length == 0) {
        return Center(
          child: Text('No suitable results, try changing query conditions'),
        );
      } else {
        return buildContent(state.res, context);
      }
    }
  }

  Widget buildContent(List<MovieModel> movies, BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Container(
      height: width / 1.75,
      margin: EdgeInsets.only(bottom: 10, top: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length > 10 ? 10 : movies.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: () {
                if (widget.onItemInteraction != null) {
                  widget.onItemInteraction(movies[index].id);
                } else {
                  debugPrint("No handle");
                }
              },
              child: _buildItem(movies[index].poster, movies[index].poster, width / 4, index == 0)
          );
        },
      ),
    );
  }

  _buildItem(String imagePath, String backdropPath, double itemHeight, bool isFirst) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      margin: EdgeInsets.only(left: isFirst ? 20 : 10, right: 10, bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Stack(
        children: <Widget>[
          Image.network(imagePath,
            fit: BoxFit.cover,
            width: itemHeight * 4 / 3,
            height: itemHeight * 1.7,
          ),
          Container(
            alignment: Alignment.bottomLeft,
            width: itemHeight * 4 / 3,
            height: itemHeight * 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red,), 
                  onPressed: null, 
                  iconSize: 20,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward), 
                  onPressed: null, 
                  iconSize: 20,
                ),
              ],
            )
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}