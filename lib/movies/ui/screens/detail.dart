import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:netflizxy/movies/bloc/movie.bloc.dart';
import 'package:netflizxy/movies/model/movie.model.dart';
import 'package:netflizxy/widgets/loading.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class Detail extends StatelessWidget {
  final int id;
  final String heroId;

  Detail({Key key, this.id, @required this.heroId}) : super(key: key);

  MovieBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<MovieBloc>(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Container(
        child: FutureBuilder(
          future: _bloc.getMovie(id),
          builder: (BuildContext _context, AsyncSnapshot<Movie> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.error != null) {
                  return Text(snapshot.error.toString());
                } else {
                  Movie movie = snapshot.data;
                  return ListView(
                    children: [
                      Container(
                        height: 250,
                        child: Stack(
                          children: [
                            Hero(
                              tag: this.heroId,
                              child: Container(
                                height: 250,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(200),
                                    bottomRight: Radius.circular(200),
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: CachedNetworkImageProvider(
                                      movie.posterPath,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.deepOrange,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                movie.popularity.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                          alignment: Alignment(0, 1.2),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          movie.title,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.only(left: 16),
                            children: movie.genres.map<Widget>((e) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(right: 8),
                                child: Text(
                                  e.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          movie.overview,
                          style: TextStyle(fontSize: 16, color: Colors.black87),
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
        ),
      ),
    );
  }
}
