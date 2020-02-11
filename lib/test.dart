import 'dart:convert';

void main() {
  String str = '{"Ratings":[{"Source": "Internet Movie Database","Value": "5.8/10"},{"Source": "Rotten Tomatoes","Value": "28%"},{"Source": "Metacritic","Value": "41/100"}]}';
  final jDecode = jsonDecode(str);
  Movie m = Movie.fromJson(jDecode);
  for(int i = 0; i < m.ratings.length; i++) {
    print(m.ratings[i].source);
  }

  print(Crew.actor.toString().split('.').last);
}

enum Crew {
  actor, director, write, NA,
}

class Movie {

  List<Rating> _ratings = [];
  
  Movie.fromJson(Map<String, dynamic> parsedJson) {
    dynamic ratings = parsedJson['Ratings'];
    for(var rating in ratings) {
      _ratings.add(Rating.fromJson(rating));
    }
  }

  List<Rating> get ratings => _ratings;
}

class Rating {
  String source;
  String value;

  Rating({String source, String value}) {
    this.source = source;
    this.value = value;
  }

  Rating.fromJson(Map<String, dynamic> parsedJson) {
    this.source = parsedJson['Source'];
    this.value = parsedJson['Value'];
    //Rating(source: source, value: value);
  }
}