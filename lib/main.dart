import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './details_movie.dart';

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
    );
  }
}

class MovieSearchPage extends StatefulWidget {
  @override
  _MovieSearchPageState createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  final TextEditingController _controller = TextEditingController();
  List movies = [];
// TODO: Implémentez cette méthode pour appeler l'API et récupérer les films
  Future<void> fetchMovies(String query) async {
    final String key_api = "b444cb55";
    final String base_url = "https://www.omdbapi.com/";

    final String url = query.isEmpty
        ? '$base_url?apikey=$key_api&s=movie'
        : '$base_url?apikey=$key_api&s=$query';

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
        title: Container(
          width: double.infinity,
          child: Text(
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
              decoration: InputDecoration(
                labelText: "Rechecher Votre Film",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => fetchMovies(_controller.text),
              child: Text("Chercher"),
            ),

// TODO: Affichez la liste des films ou un message si aucun résultat
            Expanded(
              child: movies.isEmpty
                  ? Center(child: Text("Aucun Film Trouvez"))
                  : ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return ListTile(
                          title: Text(movie['Title']),
                          subtitle: Text(movie['Year']),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailPage(movie: movie),
                            ),
                          ),
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
