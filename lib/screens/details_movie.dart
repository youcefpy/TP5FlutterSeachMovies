import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class MovieDetailPage extends StatefulWidget {
  // final Map movie;
  // MovieDetailPage({required this.movie});
  static const rootName = "/movie-details";

  const MovieDetailPage({super.key});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _reviewController = TextEditingController();
    final TextEditingController _ratingController = TextEditingController();
    final movie =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    print("Movie data: $movie");
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
        child: SingleChildScrollView(
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
                    Text("ID : ${movie['imdbID']}"),
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
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _reviewController,
                decoration: InputDecoration(labelText: "Votre Avis"),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _ratingController,
                decoration: InputDecoration(labelText: "Note (1-5)"),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  final review = _reviewController.text.trim();
                  final ratingText = _ratingController.text.trim();
                  final rating = int.tryParse(ratingText);

                  // Validate inputs
                  if (review.isEmpty ||
                      rating == null ||
                      rating < 1 ||
                      rating > 5) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Invalid entrée! SVP resaisir encore."),
                      ),
                    );
                    return;
                  }

                  try {
                    await FirebaseFirestore.instance.collection('reviews').add({
                      'movieId': movie['imdbID'],
                      'avis': review,
                      'rating': rating,
                      'timestamp': FieldValue.serverTimestamp(),
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Avis envoyé avec succès!")),
                    );

                    _reviewController.clear();
                    _ratingController.clear();
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Erreur lors de l'envoi de l'avis!")),
                    );
                  }
                },
                child: const Text("Soumettre Avis"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
