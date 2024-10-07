import 'package:flutter/material.dart';
import './favorie_screen.dart';

class TabScreen extends StatefulWidget {
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Widget> _pages = [
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favorie",
          ),
        ],
      ),
    );
  }
}
