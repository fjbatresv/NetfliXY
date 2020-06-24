import 'package:netflizxy/movies/model/movie.model.dart';
import 'package:netflizxy/movies/model/result.model.dart';
import 'package:netflizxy/movies/repository/tmdb.api.dart';
import 'package:netflizxy/movies/model/genre.model.dart';
import 'package:netflizxy/movies/model/result.model.dart';
import 'package:netflizxy/movies/repository/tmdb.api.dart';

class TmdbRepository {
  TmdbApi _api = TmdbApi();

  Future<Result> getPopulars() => _api.getPopulars();

  Future<List<Genre>> getGenres() => _api.getGenres();

  Future<Movie> getMovie(int id) => _api.getMovie(id);

  Future<Result> search(String query) => _api.search(query);

  Future<Result> getMoviesByGenres(int id) => _api.getMoviesByGenres(id);

  Future<List<Genre>> getHomeGenresMovies() => _api.getHomeGenresMovies();
}
