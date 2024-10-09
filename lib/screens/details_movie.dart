import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';

class MovieDetailPage extends StatelessWidget {
  // final Map movie;
  // MovieDetailPage({required this.movie});
  static const rootName = "/movie-details";

  const MovieDetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    final movie =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final favoriteMovieProvider = Provider.of<FavorieMovie>(context);
    final isFavorite = favoriteMovieProvider.isfavorite(movie);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: SizedBox(
          width: double.infinity,
          child: Text(
            movie['Title'],
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (isFavorite) {
                favoriteMovieProvider.removeFromFavorite(movie);
              } else {
                favoriteMovieProvider.addFavoriteMovie(movie);
              }
            },
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            color: Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //details de film
            Card(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Image.network(
                      movie['Poster'],
                      height: 200,
                      width: double.infinity,
                    ),
                  ),
                  Text(
                    "Titre : ${movie['Title']}",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "Year : ${movie['Year']}",
                  ),
                  Text(
                    "Type: ${movie['Type']}",
                  ),
                  Text(
                    'Note: ${movie['Rated']}',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
