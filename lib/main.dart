import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

import 'movies/bloc/movie.bloc.dart';
import 'movies/ui/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends  StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        title: 'Netflixy',
        home: Home(),
      ),
      bloc: MovieBloc(),
    );
  }

}