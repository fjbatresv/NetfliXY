import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:netflizxy/movies/bloc/movie.bloc.dart';
import 'package:netflizxy/movies/model/genre.model.dart';
import 'package:netflizxy/movies/model/movie.model.dart';
import 'package:netflizxy/movies/model/result.model.dart';
import 'package:netflizxy/movies/ui/widgets/moviecard.dart';
import 'package:netflizxy/widgets/loading.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

import 'detail.dart';

class Home extends StatelessWidget {
  MovieBloc _bloc;
  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<MovieBloc>(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[50],
        elevation: 0,
        title: Text(
          "NetfliXY",
          style: TextStyle(color: Colors.orange, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            getPopulars(context),
            getGenres(),
          ],
        ),
      ),
    );
  }

  Widget getPopulars(BuildContext context) {
    return FutureBuilder(
      future: _bloc.getPopulars(),
      builder: (BuildContext _context, AsyncSnapshot<Result> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Loading();
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.error != null) {
              return Text(snapshot.error.toString());
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Detail(id: snapshot.data.results[0].id),
                        ),
                      ),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: CachedNetworkImageProvider(
                              snapshot.data.results[0].posterPath,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8, left: 16),
                    child: Text(
                      "Populares",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children:
                          snapshot.data.results.map<Widget>((Movie movie) {
                        return MovieCard(
                          movie: movie,
                        );
                      }).toList(),
                    ),
                  )
                ],
              );
            }
            break;
          default:
            return Loading();
            break;
        }
      },
    );
  }

  Widget getGenres() {
    List<Widget> elements = [];
    return FutureBuilder(
      future: _bloc.getHomeGenresMovies(),
      builder: (BuildContext _context, AsyncSnapshot<List<Genre>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.error != null) {
              elements.add(Text(snapshot.error.toString()));
            } else {
              snapshot.data.forEach((element) async {
                elements.add(
                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 16),
                    child: Text(
                      element.name,
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                );
                elements.add(
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(0),
                      children: element.movies.map<Widget>((Movie movie) {
                        return MovieCard(
                          movie: movie,
                        );
                      }).toList(),
                    ),
                  ),
                );
              });
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: elements,
            );
            break;
          case ConnectionState.none:
          case ConnectionState.waiting:
          default:
            return Loading();
            break;
        }
      },
    );
  }
}
