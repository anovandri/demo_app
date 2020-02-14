import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:indoxx1/data/omdb/model/movie.dart';
import 'package:indoxx1/presentation/bloc/event/movie_favorite_event.dart';
import 'package:indoxx1/presentation/bloc/movie_favorite_bloc.dart';

final MovieFavoriteBloc movieFavoriteBloc = MovieFavoriteBloc();

class IconButtonSaveWidget extends StatefulWidget {
  MovieModel movie;

  IconButtonSaveWidget({this.movie});

  @override
  _IconButtonSaveWidgetState createState() => _IconButtonSaveWidgetState();
}

class _IconButtonSaveWidgetState extends State<IconButtonSaveWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.add,
      ),
      onPressed: () {
        AlertDialog alertDialog = AlertDialog(
            title: Text("Indo XX1"),
            content: Text("Do you want to save as your favorite ?"),
            actions: [
              FlatButton(
                  onPressed: () {
                    movieFavoriteBloc.add(MovieFavoriteSaveEvent(
                        id: widget.movie.imdbId,
                        label: widget.movie.title,
                        rating: widget.movie.imdbRating,
                        title: widget.movie.title,
                        year: widget.movie.year,
                        poster: widget.movie.poster));

                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Text('Confirm')),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Text('Cancel')),
            ]);

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return alertDialog;
            });
      },
    );
  }
}
