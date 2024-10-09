# Flutter tutorial TP Recherche et afficher les détails d'un film 
Une application qui permet de rechercher des films via l'API OMDB et d'afficher les détails d'un film sélectionné. Les utilisateurs peuvent également ajouter des films à leur liste de favoris

# API OMDB
ON utilise l'API OMDB pour récupérer les informations sur les films.

# Flutter Version 
La version utilisée pour ce TP est `Flutter 3.24.3`. 

# Bibliotheque utiliser
`http` : pour faire des requêtes à l'API OMDB et récupérer les informations sur les films.
`Provider`: pour gérer l'état de l'application, en particulier pour la gestion des films favoris.

# Structure du projet
`main.dart` : Point d'entrée de l'application.
`movie_search.dart` : Permet à l'utilisateur de rechercher des films et d'afficher les résultats.
`details_movie.dart`:Affiche les détails du film sélectionné, avec la possibilité de l'ajouter aux favoris.
`favorie_screen.dart`: Affiche la liste des films favoris de l'utilisateur.

# Installation
1. Clonez ce dépôt : `git clone https://github.com/youcefpy/TP5FlutterSeachMovies.git`
2. Accédez au dossier du projet : `cd TP5FlutterSeachMovies`
3. Installez les dépendances : `flutter pub get`
4. Exécutez l'application: `flutter run`


# Screen shots
<img width="374" alt="Capture d’écran 2024-10-09 001948" src="https://github.com/user-attachments/assets/9d666e29-0fe5-428e-b278-d24d38e4adca">
<img width="373" alt="Capture d’écran 2024-10-09 002127" src="https://github.com/user-attachments/assets/7ab15372-99a8-4100-9d0b-3f695fc3c57f">

<img width="377" alt="Capture d’écran 2024-10-09 002155" src="https://github.com/user-attachments/assets/22b024ab-7076-4fec-a6f2-4d02319e03f6">

<img width="373" alt="Capture d’écran 2024-10-09 002230" src="https://github.com/user-attachments/assets/d38b3d3e-cd2a-4e61-a68d-e54dfc85100d">

