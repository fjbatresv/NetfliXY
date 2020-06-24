import 'package:netflizxy/movies/model/genre.model.dart';

class Movie {
  int id;
  int voteCount;
  String title;
  double popularity;
  String posterPath;
  String overview;
  List<Genre> genres;

  Movie.fromJson(Map<String, dynamic> parsed) {
    id = parsed['id'];
    voteCount = parsed['vote_count'];
    title = parsed['title'];
    posterPath = 'https://image.tmdb.org/t/p/w185${parsed['poster_path']}';
    popularity = parsed['popularity'];
    overview = parsed['overview'];
    if (parsed['genres'] != null) {
      genres = parsed['genres'].map<Genre>((data) {
        return Genre.fromJson(data);
      }).toList();
    }
  }
}
