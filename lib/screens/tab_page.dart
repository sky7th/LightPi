import 'package:flutter/material.dart';
import 'package:light_key/screens/admin_page.dart';
import 'package:light_key/screens/home_page.dart';
import 'package:light_key/screens/search_page.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class TabPage extends StatefulWidget {
//  final FirebaseUser user;

  TabPage();

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndex = 0;

  List _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(),
      SearchPage(),
      AdminPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: _pages[_selectedIndex]),
        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(iconData: Icons.home, title: "Home"),
            TabData(iconData: Icons.search, title: "Search"),
            TabData(iconData: Icons.shopping_cart, title: "Basket")
          ],
          onTabChangedListener: (position) {
            setState(() {
              _selectedIndex = position;
            });
          },
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
