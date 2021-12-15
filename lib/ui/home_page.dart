import 'package:dietary_works_capstone/ui/list_page.dart';
import 'package:dietary_works_capstone/ui/profile_page.dart';
import 'package:dietary_works_capstone/ui/search_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  static const String _homeText = 'Beranda';
  static const String _searchText = 'Pencarian';
  static const String _profileText = 'Resep';

  final List<Widget> _listWidget = [
    const ListPage(),
    const SearchPage(),
    const ProfilePage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: _homeText,
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.search), label: _searchText),
    const BottomNavigationBarItem(
        icon: Icon(Icons.notes), label: _profileText),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
        selectedItemColor: Colors.deepOrangeAccent,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

}
