import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indoxx1/data/indoxxi/model/movie.dart';
import 'package:indoxx1/presentation/bloc/event/movie_favorite_event.dart';
import 'package:indoxx1/presentation/bloc/movie_favorite_bloc.dart';
import 'package:indoxx1/presentation/bloc/state/movie_favorite_state.dart';

final MovieFavoriteBloc movieBloc = MovieFavoriteBloc();

class SlideShowView extends StatefulWidget {
  final Function(String imdbId) onItemInteraction;

  const SlideShowView({Key key, this.onItemInteraction}) : super(key: key);

  @override
  _SlideShowViewState createState() => _SlideShowViewState();
}

class _SlideShowViewState extends State<SlideShowView> {
  @override
  Widget build(BuildContext context) {
    movieBloc.add(MoviePopularFetchEvent());
    return Container(
        child: BlocBuilder(
      bloc: movieBloc,
      builder: (BuildContext context, MovieFavoriteState state) {
        return renderItem(state);
      },
    ));
  }

  Widget renderItem(state) {
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
        return buildContent(state.res, context);
      }
    }
  }

  Widget buildContent(List<MovieFavoriteModel> movies, BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: CarouselSlider(
        height: width / 2,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        pauseAutoPlayOnTouch: Duration(seconds: 10),
        enlargeCenterPage: true,
        items: movies.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return InkWell(
                onTap: () {
                  if (widget.onItemInteraction != null) {
                    widget.onItemInteraction(item.id);
                  } else {
                    debugPrint("No handle");
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: _buildItem(item.poster, item.title)
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  _buildItem(String imagePath, String title) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      margin: EdgeInsets.only(left: 5, right: 5, bottom: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: <Widget>[
            Image.network(
              imagePath,
              fit: BoxFit.cover,
              height: constraints.biggest.height,
              width: constraints.biggest.width,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              width: constraints.biggest.width,
              height: constraints.biggest.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.5, 0.7, 0.9],
                  colors: [
                    Color(0x00000000),
                    Color(0x00000000),
                    Color(0x22000000),
                    Color(0x66000000),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  title?.toUpperCase() ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Muli'),
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
