import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indoxx1/data/indoxxi/model/movie.dart';
import 'package:indoxx1/presentation/bloc/event/movie_favorite_event.dart';
import 'package:indoxx1/presentation/bloc/movie_favorite_bloc.dart';
import 'package:indoxx1/presentation/bloc/state/movie_favorite_state.dart';

final MovieFavoriteBloc movieFavoriteBloc = MovieFavoriteBloc();

class FavoriteListWidget extends StatefulWidget {
  final Function(String imdbId) onItemInteraction;

  FavoriteListWidget({Key key, this.onItemInteraction}) : super(key: key);

  @override
  _FavoriteListWidgetState createState() => _FavoriteListWidgetState();
}

class _FavoriteListWidgetState extends State<FavoriteListWidget> {
  Widget _renderItem(state) {
    if (state is MovieFavoriteUninitializedState) {
      return Center(
        child: Text('No content yet'),
      );
    } else if (state is MovieFavoriteLoadingState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is MovieFavoriteErrorState) {
      return Center(
        child: Text('An error occured'),
      );
    } else if (state is MovieFavoriteLoadedState) {
      if (state.res.length == 0) {
        return Center(
          child: Text('No suitable results, try changing query conditions'),
        );
      } else {
        return _buildContent(state.res, context);
      }
    }
  }

  Widget _buildContent(List<MovieFavoriteModel> movies, BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
        height: height,
        margin: EdgeInsets.only(bottom: 10, top: 20),
        child: GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          children: List.generate(movies.length, (index) {
            return InkWell(
              onTap: () {
                if (widget.onItemInteraction != null) {
                  widget.onItemInteraction(movies[index].id);
                } else {
                  debugPrint("No handle");
                }
              },
              child: _buildItem(movies[index].poster, movies[index].poster,
                  width / 4, index == 0, movies[index].year),
            );
          }),
        ));
  }

  _buildItem(String imagePath, String backdropPath, double itemHeight,
      bool isFirst, int year) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      margin: EdgeInsets.only(left: isFirst ? 20 : 10, right: 10, bottom: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Stack(children: <Widget>[
        Image.network(
          imagePath,
          fit: BoxFit.cover,
          width: itemHeight * 4 / 2,
          height: itemHeight * 1.57,
        ),
        Container(
            alignment: Alignment.bottomLeft,
            width: itemHeight * 4 / 2,
            height: itemHeight * 3,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    year.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Muli'),
                  ),
                ]))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    movieFavoriteBloc.add(MovieFavoriteFetchEvent());
    return Container(
        child: BlocBuilder(
      bloc: movieFavoriteBloc,
      builder: (BuildContext context, MovieFavoriteState state) {
        return _renderItem(state);
      },
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
