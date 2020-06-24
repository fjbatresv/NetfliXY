import 'dart:convert';

import 'package:http/http.dart';
import 'package:netflizxy/movies/model/genre.model.dart';
import 'package:netflizxy/movies/model/movie.model.dart';
import 'package:netflizxy/movies/model/result.model.dart';

class TmdbApi {
  Client _client = Client();
  final _apiKey = '<Your API Key>';

  Future<Result> getPopulars() async {
    final response = await _client.get(
        "http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey&language=es-GT");
    return response.statusCode == 200
        ? Result.fromJson(json.decode(response.body))
        : throw Exception('Error on API');
  }

  Future<List<Genre>> getGenres() async {
    final response = await _client.get(
        "https://api.themoviedb.org/3/genre/movie/list?api_key=$_apiKey&language=es-GT");
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      if (map['genres'] != null) {
        return map['genres'].map<Genre>((data) {
          return Genre.fromJson(data);
        }).toList();
      }
    } else {
      throw Exception("Error on API");
    }
  }

  Future<Movie> getMovie(int id) async {
    final response = await _client.get(
        "https://api.themoviedb.org/3/movie/$id?api_key=$_apiKey&language=es-GT");
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      return Movie.fromJson(map);
    } else {
      throw Exception("Error on API");
    }
  }

  Future<Result> getMoviesByGenres(int id) async {
    final response = await _client.get(
        "https://api.themoviedb.org/3/discover/movie?api_key=$_apiKey&with_genres=$id&sort_by=popularity.desc&language=es-GT");
    return response.statusCode == 200
        ? Result.fromJson(json.decode(response.body))
        : throw Exception('Error on API');
  }

  Future<Result> search(String query) async {
    final response = await _client.get(
        "https://api.themoviedb.org/3/search/movie?api_key=$_apiKey&language=es-GT&page=1&include_adult=false&query=$query");
    return response.statusCode == 200
        ? Result.fromJson(json.decode(response.body))
        : throw Exception('Error on API');
  }

  Future<List<Genre>> getHomeGenresMovies() async {
    List<Genre> genres = [];
    List<Genre> tmps = await this.getGenres();
    tmps.shuffle();
    for (var i = 0; i < 4; i++) {
      Genre element = tmps[i];
      Result result = await this.getMoviesByGenres(element.id);
      element.movies = result.results;
      genres.add(element);
    }
    return genres;
  }
}
