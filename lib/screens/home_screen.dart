import 'package:badges/badges.dart';
import 'package:cryptox/screens/all_coins_screen.dart';
import 'package:cryptox/screens/popular_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;
  static final List<Widget> _items = <Widget>[
    PopularScreen(),
    const CoinScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _items.elementAt(_selectedIndex)
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0))
        ),
        child: BottomNavigationBar(
          elevation: 3.0,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart),label: "All Coins"),
            ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.lightBlue,
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
