import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indoxx1/data/omdb/model/movie.dart';
import 'package:indoxx1/presentation/bloc/event/movie_event.dart';
import 'package:indoxx1/presentation/bloc/movie_bloc.dart';
import 'package:indoxx1/presentation/bloc/state/movie_state.dart';

final MovieBloc movieBloc = MovieBloc();

class MovieListView extends StatefulWidget {
  final Function(String imdbId) onItemInteraction;

  MovieListView({Key key, this.onItemInteraction}) : super(key: key);

  @override
  _MovieListView createState() => _MovieListView();
} 

class _MovieListView extends State<MovieListView> {
  @override
  Widget build(BuildContext context) {
    movieBloc.add(MovieFetch(query: ''));
    return Container(child: BlocBuilder(bloc: movieBloc, builder: (BuildContext context, MovieState state) {
          return renderItem(state);
    },));
  }

  Widget renderItem(state) {
    if (state is MovieUninitialized) {
      return Center(
        child: Text('No content yet'),
      );
    } else if (state is MovieLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is MovieError) {
      return Center(
        child: Text('An error occured'),
      );
    } else if (state is MovieLoaded) {
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
                  widget.onItemInteraction(movies[index].imdbId);
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
      child: Image.network(imagePath,
        fit: BoxFit.cover,
        width: itemHeight * 4 / 3,
        height: itemHeight / 2,),
    );
  }
}