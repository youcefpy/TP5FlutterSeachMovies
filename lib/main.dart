import 'package:flutter/material.dart';
import './details_movie.dart';
import 'screens/movie_serach_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TP5 Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieSearchPage(),
      routes: {
        '/movie-details': (ctx) => MovieDetailPage(),
      },
    );
  }
}
