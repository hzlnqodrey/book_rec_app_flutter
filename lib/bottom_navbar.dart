import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'menu_tambahan.dart';
import 'profile.dart';
import 'screens.dart/loadingscreen.dart';
import 'package:projekmobile/kesan_pesan.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

var l = [
  "mystery",
  "fantasy",
  "horror",
  "health"
];

class _NavState extends State<Nav> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    loadingscreen(l: l), // Mengganti loadingscreen dengan HomeScreen
    ExtraMenu(),
    KesanPesan(),
    Profil(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: GNav(
            backgroundColor: Colors.white,
            color: Colors.black,
            tabBackgroundColor: Color.fromARGB(255, 170, 170, 170),
            gap: 8,
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(
                    () {
                  _selectedIndex = index;
                },
              );
            },
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.add, text: 'Extra Menu'),
              GButton(icon: Icons.library_books, text: 'Kesan dan Pesan'),
              GButton(icon: Icons.account_box, text: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Nav(),
  ));
}
