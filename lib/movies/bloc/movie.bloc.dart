import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:netflizxy/movies/model/genre.model.dart';
import 'package:netflizxy/movies/model/movie.model.dart';
import 'package:netflizxy/movies/model/result.model.dart';
import 'package:netflizxy/movies/repository/tmdb.repo.dart';

class MovieBloc implements Bloc {
  TmdbRepository _repository = TmdbRepository();

  Future<Result> getPopulars() => _repository.getPopulars();

  Future<List<Genre>> getGenres() => _repository.getGenres();

  Future<Movie> getMovie(int id) => _repository.getMovie(id);

  Future<Result> search(String query) => _repository.search(query);

  Future<Result> getMoviesByGenres(int id) => _repository.getMoviesByGenres(id);

  Future<List<Genre>> getHomeGenresMovies() => _repository.getHomeGenresMovies();

  @override
  void dispose() {}
}
