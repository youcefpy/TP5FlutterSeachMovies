import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

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
    final movie =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final favoriteMovieProvider = Provider.of<FavorieMovie>(context);
    final isFavorite = favoriteMovieProvider.isfavorite(movie);
    //text controller review
    final TextEditingController _reviewController = TextEditingController();
    // text controller ratting
    final TextEditingController _ratingController = TextEditingController();

    //collection referance => get the doc "reviews where i show the comments"
    final fetchData = FirebaseFirestore.instance
        .collection("reviews")
        .where("movieId", isEqualTo: movie['imdbID']);

    void insertDataInFb() async {
      //stock the text in the variable review
      final review = _reviewController.text.trim();
      //stock ratting in rattingText
      final ratingText = _ratingController.text.trim();
      //convert ratting from text (string) to int
      final rating = int.tryParse(ratingText);
      //check if the review field in empty or ratting is null or lt 1 or gt5
      if (review.isEmpty || rating == null || rating < 1 || rating > 5) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalide entrée! SVP resaisir encore."),
          ),
        );
        return;
      }

      try {
        //init firebaseFireStore to store the data in the doc review
        await FirebaseFirestore.instance.collection('reviews').add({
          'movieId': movie['imdbID'],
          'avis': review,
          'rating': rating,
          'timestamp': FieldValue.serverTimestamp(),
        });
        //showing a message in the snack bar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Avis envoyé avec succès!")),
        );
        //clear the fields
        _reviewController.clear();
        _ratingController.clear();
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erreur lors de l'envoi de l'avis!")),
        );
      }
    }

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
                height: 30,
              ),
              //ajouter un streamBuilder
              StreamBuilder(
                  stream: fetchData.snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                streamSnapshot.data!.docs[index];
                            final timestamp = documentSnapshot['timestamp'];
                            DateTime dateTime;

                            if (timestamp is Timestamp) {
                              dateTime = timestamp.toDate();
                            } else if (timestamp is String) {
                              dateTime = DateTime.parse(timestamp);
                            } else {
                              dateTime = DateTime.now();
                            }

                            return Material(
                              child: ListTile(
                                leading: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      DateFormat('dd-MM-yyyy').format(dateTime),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      DateFormat("HH-mm").format(dateTime),
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                title: Text(
                                  documentSnapshot['avis'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: 16,
                                    ),
                                    Text(
                                      documentSnapshot['rating'].toString(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
              SizedBox(
                height: 30,
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
                onPressed: () => insertDataInFb(),
                child: const Text("Soumettre Avis"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
