import 'movie.model.dart';

class Genre {
  int id;
  String name;
  List<Movie> movies = [];

  Genre.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}
