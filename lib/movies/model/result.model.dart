import 'movie.model.dart';

class Result {
  int page;
  int totalResults;
  int totalPages;
  List<Movie> results;

  Result.fromJson(Map<String, dynamic> parsed) {
    page = parsed['page'];
    totalResults = parsed['total_results'];
    totalPages = parsed['total_pages'];
    if (parsed['results'] != null) {
      results = parsed['results'].map<Movie>((res) {
        return Movie.fromJson(res);
      }).toList();
    }
  }
}
