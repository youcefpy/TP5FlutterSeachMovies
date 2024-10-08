import 'package:flutter/material.dart';

class FavorieMovie extends ChangeNotifier {
  List<Map<String, dynamic>> _favoriteMovies = [];

  List<Map<String, dynamic>> get favoriteMovies => _favoriteMovies;

  void addFavoriteMovie(Map<String, dynamic> movie) {
    _favoriteMovies.add(movie);
    notifyListeners();
  }

  void removeFromFavorite(Map<String, dynamic> movie) {
    _favoriteMovies.removeWhere((m) => m['Title'] == movie['Title']);
    notifyListeners();
  }

  bool isfavorite(Map<String, dynamic> movie) {
    return _favoriteMovies.any((m) => m['Title'] == movie['Title']);
  }
}
