import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'details_movie.dart';
// import '../details_movie.dart';

class MovieSearchPage extends StatefulWidget {
  const MovieSearchPage({super.key});

  @override
  _MovieSearchPageState createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  final TextEditingController _controller = TextEditingController();
  List movies = [];

  void selectDetailsPage(BuildContext ctx, movie) {
    Navigator.of(ctx).pushNamed(MovieDetailPage.rootName, arguments: movie);
  }

// TODO: Implémentez cette méthode pour appeler l'API et récupérer les films
  Future<void> fetchMovies(String query) async {
    const String keyApi = "b444cb55";
    const String baseUrl = "https://www.omdbapi.com/";

    final String url = query.isEmpty
        ? '$baseUrl?apikey=$keyApi&s=movie'
        : '$baseUrl?apikey=$keyApi&s=$query';

    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        movies = data['Search'] ?? [];
      });
    } else {
      throw Exception("Faield to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: SizedBox(
          width: double.infinity,
          child: const Text(
            'YouMovies',
            style: TextStyle(fontSize: 30, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
// TODO: Complétez la TextField pour saisir le titre du film
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Rechecher Votre Film",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => fetchMovies(_controller.text),
              child: const Text("Chercher"),
            ),

// TODO: Affichez la liste des films ou un message si aucun résultat
            Expanded(
              child: movies.isEmpty
                  ? const Center(
                      child: Text("Aucun Film Trouvez"),
                    )
                  : ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return ListTile(
                          leading: CircleAvatar(
                            child: Image.network(movie['Poster']),
                          ),
                          title: Text(movie['Title']),
                          subtitle: Text(movie['Year']),
                          onTap: () => selectDetailsPage(context, movie),
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
