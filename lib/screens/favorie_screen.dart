import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';

class FavoritScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteMovies = Provider.of<FavorieMovie>(context).favoriteMovies;
    final favoriteMovieProvider = Provider.of<FavorieMovie>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Container(
          width: double.infinity,
          child: Text(
            "Favorie",
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: favoriteMovies.isEmpty
          ? Center(
              child: Text("Y a pas de film prefere"),
            )
          : ListView.builder(
              itemCount: favoriteMovies.length,
              itemBuilder: (ctx, index) {
                final movie = favoriteMovies[index];
                return ListTile(
                  leading: Image.network(
                    movie['Poster'],
                  ),
                  title: Text(
                    movie['Title'],
                  ),
                  subtitle: Text(
                    "Année: ${movie['Year']}",
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () =>
                        favoriteMovieProvider.removeFromFavorite(movie),
                  ),
                );
              }),
    );
  }
}
