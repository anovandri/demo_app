import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indoxx1/data/omdb/model/movie.dart';
import 'package:indoxx1/presentation/bloc/event/movie_event.dart';
import 'package:indoxx1/presentation/bloc/movie_bloc.dart';
import 'package:indoxx1/presentation/bloc/state/movie_state.dart';
import 'package:random_words/random_words.dart';

final MovieBloc movieBloc = MovieBloc();

class OmdbListWidget extends StatefulWidget {
  final Function(String imdbId) onItemInteraction;

  OmdbListWidget({Key key, this.onItemInteraction}) : super(key: key);

  @override
  _OmdbListWidgetState createState() => _OmdbListWidgetState();
}

class _OmdbListWidgetState extends State<OmdbListWidget> {
  Widget renderItem(state) {
    if (state is MovieUninitializedState) {
      return Center(
        child: Text('No content yet'),
      );
    } else if (state is MovieLoadingState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is MovieErrorState) {
      return Center(
        child: Text('An error occured'),
      );
    } else if (state is MovieLoadedState) {
      if (state.res.length == 0) {
        return Center(
          child: Text('No suitable results, try changing query conditions'),
        );
      } else {
        return buildContent(state.res, context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    movieBloc.add(MovieFetchEvent(title: _getTitle(), type: 'movie'));
  } 

  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
      BlocBuilder(
      bloc: movieBloc,
      builder: (BuildContext context, MovieState state) {
        return renderItem(state);
      },
    )
    // BlocConsumer<MovieBloc, MovieState>(builder: 
    //  (BuildContext context, MovieState state) {
    //     return renderItem(state);
    //   },
    //  listener: (context, state) {
    //    return renderItem(state);
    //  })
    );
  }

  Widget buildContent(List<MovieModel> movies, BuildContext context) {
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
                widget.onItemInteraction(movies[index].imdbId);
              } else {
                debugPrint("No handle");
              }
            },
            child: _buildItem(movies[index].poster, movies[index].poster,
                width / 4, index == 0, movies[index].year),
          );
        }),
      ),
    );
  }

  _buildItem(String imagePath, String backdropPath, double itemHeight,
      bool isFirst, int year) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      margin: EdgeInsets.only(left: isFirst ? 20 : 10, right: 10, bottom: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Stack(
        children: <Widget>[
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
                ],
              )),
        ],
      ),
    );
  }

  String _getTitle() {
    var rng = new Random();
    var l = new List.generate(12, (_) => rng.nextInt(1000));
    var k = l.first;
    var m = 0;
    String randomTitle;
    nouns.take(1000).forEach((v) {
      m++;
      if (m == k) {
        randomTitle = v;
      }
    });
    return randomTitle;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
