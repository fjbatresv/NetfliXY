import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflizxy/movies/model/movie.model.dart';
import 'package:netflizxy/movies/ui/screens/detail.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String heroId = DateTime.now().millisecondsSinceEpoch.toString();
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Detail(
            id: movie.id,
            heroId: heroId,
          ),
        ),
      ),
      child: Hero(
        tag: heroId,
        child: Container(
          width: 100,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                movie.posterPath,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
