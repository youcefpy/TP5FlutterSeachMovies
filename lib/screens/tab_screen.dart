import 'package:flutter/material.dart';
import './favorie_screen.dart';
import './movie_serach_page.dart';
// import './details_movie.dart';

class TabScreen extends StatefulWidget {
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Widget> _pages = [
    MovieSearchPage(),
    FavoritScreen(),
  ];
  int _selectPageIndex = 0;
  void _selectedPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.movie,
              color: Colors.white,
            ),
            label: "Movies",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            label: "Favorie",
          ),
        ],
      ),
    );
  }
}
