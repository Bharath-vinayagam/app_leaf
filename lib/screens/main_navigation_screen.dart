import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'camera_screen.dart';
import 'result_screen.dart';
import 'history_screen.dart';
import 'settings_screen.dart';
import 'about_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    HomeScreen(),
    _DetectionResultsScreenPlaceholder(),
    AboutScreen(),
    HistoryScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 16,
        backgroundColor: Colors.white.withOpacity(0.95),
        selectedItemColor: Colors.green.shade800,
        unselectedItemColor: Colors.grey.shade400,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 34,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.eco, size: 34),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics, size: 32),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline_rounded, size: 32),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, size: 32),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 32),
            label: '',
          ),
        ],
      ),
    );
  }
}

class _DetectionResultsScreenPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Detection Results Page (to be implemented)'));
  }
} 