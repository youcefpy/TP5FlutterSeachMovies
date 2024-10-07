import 'package:flutter/material.dart';

class MovieDetailPage extends StatelessWidget {
  // final Map movie;
  // MovieDetailPage({required this.movie});
  @override
  Widget build(BuildContext context) {
    final movie =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Container(
          width: double.infinity,
          child: Text(
            movie['Title'],
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
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
                  SizedBox(
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
                    style: TextStyle(
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
