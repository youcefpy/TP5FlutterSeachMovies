import 'package:flutter/material.dart';
import 'screens/details_movie.dart';
// import './screens/movie_serach_page.dart';
import './screens/tab_screen.dart';
import 'package:provider/provider.dart';
import './providers/favorite_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // List<MovieDetailPage> _favoriteMovies = [];
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FavorieMovie(),
        ),
      ],
      child: MaterialApp(
        title: 'TP5 Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: MovieSearchPage(),
        initialRoute: '/',
        routes: {
          '/': (ctx) => TabScreen(),
          MovieDetailPage.rootName: (ctx) => MovieDetailPage(),
        },
      ),
    );
  }
}
