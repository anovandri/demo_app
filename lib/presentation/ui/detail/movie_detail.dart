import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:indoxx1/common/util/my_scroll_behavior.dart';
import 'package:indoxx1/data/omdb/model/movie.dart';
import 'package:indoxx1/presentation/bloc/event/movie_event.dart';
import 'package:indoxx1/presentation/bloc/event/movie_favorite_event.dart';
import 'package:indoxx1/presentation/bloc/movie_bloc.dart';
import 'package:indoxx1/presentation/bloc/movie_favorite_bloc.dart';
import 'package:indoxx1/presentation/bloc/state/movie_favorite_state.dart';
import 'package:indoxx1/presentation/bloc/state/movie_state.dart';

final MovieBloc movieBloc = MovieBloc();
final MovieFavoriteBloc movieFavoriteBloc = MovieFavoriteBloc();

class MovieDetailView extends StatefulWidget {
  final String id;

  MovieDetailView({this.id});

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetailView> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    movieBloc.add(MovieDetailFetchEvent(id: widget.id));
    return
    Scaffold(
      body:  BlocListener<MovieFavoriteBloc, MovieFavoriteState>(bloc: movieFavoriteBloc,
        listener: (context, state) {
        _renderFavoriteItem(context, state);
      }, child: Stack(
        children: <Widget>[
          _buildBody(context),
          Positioned(
            //Place it at the top, and not use the entire screen
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              title: Text(""),
              centerTitle: true,
              brightness: Brightness.light,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),),
    );
  }

  Widget _renderItem(state) {
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
    } else if (state is MovieSingleLoadedState) {
      if (state.res == null) {
        return Center(
          child: Text('No suitable results, try changing query conditions'),
        );
      } else {
        return _buildContent(state.res, context);
      }
    }
  }

  _renderFavoriteItem(BuildContext context, state) {
    if (state is MovieFavoriteSaveState) {
      String response;
      if (state.res == null) {
        response = 'Failed when tried to add new favorite movie';
      } else {
        response = state.res;
      }
      final snackbar = SnackBar(
        duration: const Duration(minutes: 30),
        content: Text('Successfuly add $response as your favorite'),
        action: SnackBarAction(label: 'Back', onPressed: (){
          Navigator.of(context).pop();    
        }),
      );
      Scaffold.of(context).showSnackBar(snackbar);
      movieBloc.add(MovieDetailFetchEvent(id: widget.id));
    }
  }

  Widget _buildBody(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyScrollBehavior(),
      child: SingleChildScrollView(
        child: BlocBuilder(
          bloc: movieBloc,
          builder: (BuildContext context, MovieState state) {
            return _renderItem(state);
          },
        ),
      ),
    );
  }

  Widget _buildContent(MovieModel movie, BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        _buildBackdrop(context, movie),
        Padding(
          padding: EdgeInsets.only(top: 20),
        ),
        Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildMovieName(context, movie.title),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              _buildGenres(context, movie?.genre ?? ""),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              _buildRating(context, movie.imdbRating),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              _buildMovieInfo(
                context,
                movie.year.toString(),
                movie.country,
                movie.durationInTime,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              _buildMovieDescription(context, movie.plot),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  _buildBackdrop(BuildContext context, MovieModel movie) {
    return Container(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        var width = constraints.biggest.width;
        return Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipPath(
                    clipper: Mclipper(),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 10.0),
                                blurRadius: 10.0)
                          ]),
                      child: Container(
                        width: width,
                        height: width,
                        child: Image.network(
                          movie.poster,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.add,
                          ),
                          onPressed: () {
                            AlertDialog alreadyDialog = AlertDialog(
                              title: Text("Indo XX1"),
                              content: Text("This movie is already favorited"),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    child: Text('OK')),
                              ],
                            );

                            AlertDialog alertDialog = AlertDialog(
                                title: Text("Indo XX1"),
                                content: Text(
                                    "Do you want to save as your favorite ?"),
                                actions: [
                                  FlatButton(
                                      onPressed: () {
                                        movieFavoriteBloc.add(
                                            MovieFavoriteSaveEvent(
                                                id: movie.imdbId,
                                                label: movie.title,
                                                rating: movie.imdbRating,
                                                title: movie.title,
                                                year: movie.year,
                                                poster: movie.poster));

                                        Navigator.of(context, rootNavigator: true)
                                          .pop();
                                      },
                                      child: Text('Confirm')),
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      },
                                      child: Text('Cancel')),
                                ]);

                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return !movie.isFavorite
                                      ? alertDialog
                                      : alreadyDialog;
                                });
                          },
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: movie.isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  _buildMovieName(BuildContext context, String name) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black87,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: "Muli"),
      ),
    );
  }

  _buildGenres(BuildContext context, String genre) {
    return Container(
        alignment: Alignment.center,
        child: Text(
          genre,
          style: TextStyle(
              color: Colors.black45,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Muli"),
        ));
  }

  _buildRating(BuildContext context, double voteAverage) {
    return Container(
      alignment: Alignment.center,
      child: StarRating(
        size: 25.0,
        rating: voteAverage / 2,
        color: Colors.red,
        borderColor: Colors.black54,
        starCount: 5,
      ),
    );
  }

  _buildMovieInfo(BuildContext context, String year, String productionCountry,
      String lengths) {
    StringBuffer productionCountries = StringBuffer();
    return Container(
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          _buildMovieMoreInfoItem("Year", year.substring(0, 4) ?? ""),
          _buildMovieMoreInfoItem("Country", productionCountry ?? ""),
          _buildMovieMoreInfoItem("Length", lengths),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  _buildMovieMoreInfoItem(String title, String value) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        width: constraints.biggest.width > 100 ? 100 : double.infinity,
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Muli"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Wrap(
              children: <Widget>[
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Muli"),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  _buildMovieDescription(BuildContext context, String description) {
    return GestureDetector(
      onTap: () {
        _expand();
      },
      child: Container(
        alignment: Alignment.center,
        child: AnimatedCrossFade(
          firstChild: Text(
            description,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black87, fontSize: 14.0, fontFamily: "Muli"),
          ),
          secondChild: Text(
            description,
            style: TextStyle(
                color: Colors.black87, fontSize: 14.0, fontFamily: "Muli"),
          ),
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: kThemeAnimationDuration,
        ),
      ),
    );
  }

  void _expand() {
    setState(() {
      isExpanded ? isExpanded = false : isExpanded = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class Mclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 40.0);

    var controlPoint = Offset(size.width / 4, size.height);
    var endpoint = Offset(size.width / 2, size.height);

    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endpoint.dx, endpoint.dy);

    var controlPoint2 = Offset(size.width * 3 / 4, size.height);
    var endpoint2 = Offset(size.width, size.height - 40.0);

    path.quadraticBezierTo(
        controlPoint2.dx, controlPoint2.dy, endpoint2.dx, endpoint2.dy);

    path.lineTo(size.width, 0.0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}
