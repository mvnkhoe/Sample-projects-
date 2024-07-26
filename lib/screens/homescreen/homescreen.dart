import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../profilepage/profilepage.dart';
import '../reminder/reminderr.dart';
import '../tasks/tasks.dart';
import 'notify.dart';
import 'Home.dart';
import 'category.dart';
import 'floatingbutton.dart';
import 'topnavigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> pages = const [
    Home(),
    Tasks(),
    Notify(),
    ProfilePage(),
  ];
  int widgetIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      widgetIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[widgetIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 16, 114, 194),
              Color.fromARGB(255, 90, 167, 230),
              Color.fromARGB(255, 94, 174, 240)
            ],
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color.fromARGB(255, 144, 174, 244),
          unselectedItemColor: Colors.white.withOpacity(.60),
          selectedFontSize: 14,
          unselectedLabelStyle: const TextStyle(fontFamily: 'serif'),
          unselectedFontSize: 14,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Tasks',
              icon: Icon(Icons.notifications_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Reminder',
              icon: Icon(Icons.notifications_sharp),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
